# BMOPFTools in the Power-System Software Ecosystem

## The Ecosystem is Different for Transmission and Distribution

The power-system software landscape is often discussed as if it were a single ecosystem. In practice, transmission and distribution software have evolved along very different paths.

### Transmission Systems

Transmission-system optimization has benefited from decades of standardization and benchmarking.

Examples include:

* MATPOWER
* PowerModels.jl
* PGLib-OPF

These projects have enabled a rich ecosystem of optimization formulations, benchmark datasets, and reproducible research.

Researchers can often compare algorithms using common test systems and well-understood problem definitions.

### Distribution Systems

Distribution-system optimization remains significantly more fragmented.

Examples include:

* PowerModelsDistribution.jl
* ppOPF
* Open-DSOPF
* OpenDSS-based optimization workflows
* GridLAB-D-based workflows
* proprietary utility tools

These tools solve similar classes of problems:

* Volt-VAR optimization
* DER coordination
* Network reconfiguration
* Hosting-capacity analysis
* Distribution optimal power flow

However, they often rely on different:

* data models
* feeder representations
* assumptions
* formulations
* network conversion pipelines

As a result, reproducing results and comparing algorithms remains difficult.

---

# What BMOPFTools Is

BMOPFTools is not another distribution OPF solver.

It is infrastructure that supports the development, validation, and benchmarking of distribution-system optimization methods.

The project focuses on:

* Distribution network representation
* Analytical model construction
* Data interoperability
* Benchmark generation
* Reproducible optimization workflows

Rather than competing with optimization frameworks, BMOPFTools aims to strengthen the ecosystem around them.

---

# Relationship to Existing Optimization Frameworks

## MATPOWER

MATPOWER established many of the conventions that enabled reproducible transmission-system optimization research.

BMOPFTools does not attempt to replace MATPOWER.

Instead, it seeks to help bring similar levels of reproducibility and benchmarking to distribution-system optimization.

---

## PowerModels.jl

PowerModels provides a powerful framework for formulating and solving network optimization problems.

BMOPFTools is complementary.

PowerModels focuses on optimization formulations.

BMOPFTools focuses on the construction, representation, and management of distribution-network models that can be used by optimization frameworks.

---

## PowerModelsDistribution.jl

PowerModelsDistribution extends the PowerModels ecosystem to distribution networks.

BMOPFTools shares many of the same application domains.

However, the projects operate at different layers.

PowerModelsDistribution focuses on optimization formulations and solution methods.

BMOPFTools focuses on network representation, interoperability, benchmark construction, and analytical infrastructure.

The projects should be viewed as complementary and potentially synergistic.

---

## ppOPF

ppOPF demonstrates how distribution optimization can be integrated into the pandapower ecosystem.

BMOPFTools shares an interest in practical distribution-system optimization but focuses more strongly on reusable network representations and benchmark generation.

---

## Open-DSOPF

Open-DSOPF provides an open implementation of distribution-system optimal power flow.

BMOPFTools does not compete with its optimization capabilities.

Instead, it can provide common network representations and benchmark systems that facilitate comparison between different optimization approaches.

---

# Relationship to Distribution Modelling Tools

Examples include:

* OpenDSS
* GridLAB-D
* Power Grid Model
* PowerFactory
* PSS®SINCAL
* CYME
* Synergi Electric

These tools focus primarily on simulation and engineering analysis.

BMOPFTools can leverage information originating from such tools while providing a representation suitable for optimization and advanced analytics.

---

# A Benchmarking Gap in Distribution Optimization

One of the major challenges facing distribution-system optimization research is the lack of shared benchmark infrastructure.

Common challenges include:

* feeder conversion between tools
* inconsistent assumptions
* incompatible data models
* limited reproducibility
* difficulty comparing competing methods

The result is that many published methods are difficult to compare fairly.

BMOPFTools aims to help address this problem by enabling:

* reusable benchmark feeders
* common network representations
* transparent model transformations
* reproducible optimization workflows
* interoperability between optimization frameworks

---

# Long-Term Opportunity

Transmission optimization matured rapidly once the community converged on common benchmark systems and data formats.

Distribution optimization may require a similar evolution.

The long-term opportunity for BMOPFTools is to become a foundation for:

* benchmark creation
* model interoperability
* reproducible research
* cross-framework comparison

In this role, BMOPFTools does not replace optimization frameworks.

Instead, it helps create the conditions under which the broader distribution-optimization ecosystem can mature.
