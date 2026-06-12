# API reference

## Module

```@docs
BMOPFTools
```

## Types

```@docs
Finding
SummaryReport
Severity
ERROR
WARNING
INFO
```

## Finding accessors

```@docs
errors
warnings
infos
```

## IO

```@docs
parse_bmopf
write_bmopf
is_timeseries
get_snapshot
```

## Conversion

```@docs
from_pmd
to_pmd
```

## Top-level analysis and rendering

```@docs
analyze
render
render_terminal
render_markdown
```

## Analysis passes

```@docs
inventory_analysis
voltage_level_analysis
connectivity_analysis
diversity_analysis
operational_analysis
provenance_analysis
infeasibility_preflight
```

## Validation passes

```@docs
schema_check
completeness_check
domain_rules_check
redundancy_check
integrity_check
spec_conformance_check
benchmark_readiness_check
```
