"""
generate_enwl_benchmark.py

Applies PMDLab enrichment data to the existing four-wire BMOPF JSONs from
output/ENWL/original/ and writes enriched benchmark OPF cases to
output/ENWLbenchmark/.

Enrichments applied per file:
  1. vpn_min / vpn_max added to ALL non-source buses (0.9 and 1.1 pu using the
     enrichment v_base_V; the same bounds apply feeder-wide so buses not in the
     enrichment bus_bounds dict receive the same values).
  2. linecode i_max replaced with real cable ampacity (4-element vector, all
     equal) from enrichment linecode_ratings; fallback 600 A retained for any
     linecode not present in enrichment.
  3. DER generators added to the generator dict (terminal_map = [phase, "n"],
     SINGLE_PHASE, already set correctly in the enrichment files).
  4. slack_source cost updated from [1,1,1] to [1e-3, 1e-3, 1e-3] $/W
     (derived from MATH gen.1 c1 = 1000 $/pu-MVA ÷ S_base = 1 MVA).

Usage:
    python3 scripts/generate_enwl_benchmark.py
"""

import json
import os
import re

BMOPF_DIR = os.path.normpath(
    os.path.join(os.path.dirname(__file__), "..", "output", "ENWL", "original")
)
ENR_DIR = os.path.normpath(
    os.path.join(os.path.dirname(__file__), "..", "test", "data", "PMDLab")
)
OUT_DIR = os.path.normpath(
    os.path.join(os.path.dirname(__file__), "..", "output", "ENWLbenchmark")
)

# $/W for the slack voltage source — from PMDLab MATH gen.1 c1 = 1000 $/pu, S_base = 1 MVA
SLACK_COST_PER_W = 1e-3


def _enrichment_key(bmopf_filename):
    """Map 'Network_14_Feeder_2.json' -> 'network_14_feeder_2'."""
    return bmopf_filename.replace(".json", "").lower()


def enrich(bmopf_data, enr):
    """Return a new enriched copy of bmopf_data (modifies in place, returns it)."""
    d = bmopf_data

    # ── 1. vpn bounds on ALL non-source buses ────────────────────────────────
    v_base = enr["bases"]["v_base_V"]
    vpn_min = round(v_base * 0.9, 6)
    vpn_max = round(v_base * 1.1, 6)

    source_bus = None
    for _gid, g in d.get("voltage_source", {}).items():
        source_bus = g.get("bus")
        break

    for bid, bus in d["bus"].items():
        if bid == source_bus:
            continue
        # Override with the per-bus values from enrichment if available,
        # otherwise use the feeder-wide 0.9/1.1 pu bounds.
        if bid in enr["bus_bounds"]:
            bus["vpn_min"] = enr["bus_bounds"][bid]["vpn_min"]
            bus["vpn_max"] = enr["bus_bounds"][bid]["vpn_max"]
        else:
            bus["vpn_min"] = vpn_min
            bus["vpn_max"] = vpn_max

    # ── 2. Linecode ampacity ─────────────────────────────────────────────────
    for lcid, lc in d.get("linecode", {}).items():
        if lcid in enr["linecode_ratings"]:
            i_max_val = enr["linecode_ratings"][lcid]["i_max_A"]
            lc["i_max"] = [i_max_val, i_max_val, i_max_val, i_max_val]

    # ── 3. DER generators ───────────────────────────────────────────────────
    if "generator" not in d:
        d["generator"] = {}
    for der_id, gen in enr["generators"].items():
        d["generator"][der_id] = {
            "bus":           gen["bus"],
            "terminal_map":  gen["terminal_map"],
            "configuration": gen["configuration"],
            "p_min_W":       gen["p_min_W"],
            "p_max_W":       gen["p_max_W"],
            "cost":          [gen["cost_per_W"]],
        }

    # ── 4. Slack source cost ─────────────────────────────────────────────────
    for _gid, g in d.get("voltage_source", {}).items():
        # voltage_source entries don't carry cost — skip
        pass
    for gid, g in d.get("generator", {}).items():
        if g.get("_slack"):
            n_phases = len(g.get("terminal_map", [])) - 1  # exclude neutral
            if n_phases < 1:
                n_phases = 3
            g["cost"] = [SLACK_COST_PER_W] * n_phases

    return d


def main():
    os.makedirs(OUT_DIR, exist_ok=True)

    bmopf_files = sorted(
        f for f in os.listdir(BMOPF_DIR) if f.endswith(".json")
    )

    ok = 0
    failed = 0

    for fname in bmopf_files:
        key = _enrichment_key(fname)
        enr_file = os.path.join(ENR_DIR, f"{key}_enrichment.json")
        bmopf_file = os.path.join(BMOPF_DIR, fname)
        out_file = os.path.join(OUT_DIR, fname)

        if not os.path.exists(enr_file):
            print(f"  SKIP {fname}: no enrichment file at {enr_file}")
            failed += 1
            continue

        try:
            with open(bmopf_file) as f:
                bmopf = json.load(f)
            with open(enr_file) as f:
                enr = json.load(f)

            enriched = enrich(bmopf, enr)

            with open(out_file, "w") as f:
                json.dump(enriched, f, indent=2)

            n_buses   = sum(1 for bid in enriched["bus"]
                            if "vpn_min" in enriched["bus"][bid])
            n_ders    = sum(1 for gid in enriched["generator"]
                            if gid.startswith("der_"))
            n_lcs_upd = len(enr["linecode_ratings"])
            print(f"  {fname}: {n_buses} buses bounded, {n_lcs_upd} lc ratings, {n_ders} DERs")
            ok += 1

        except Exception as e:
            import traceback
            print(f"  ERROR {fname}: {e}")
            traceback.print_exc()
            failed += 1

    print(f"\nDone: {ok} enriched, {failed} failed.")
    print(f"Output written to: {OUT_DIR}")


if __name__ == "__main__":
    main()
