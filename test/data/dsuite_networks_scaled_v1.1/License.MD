The data in this folder is originally from
https://data.ncl.ac.uk/articles/model/Six_UK-based_Low_Voltage_Distribution_Network_Models/27175317
The data is CC BY 4.0.

This dataset collects six low voltage (LV) distribution networks, with three networks from each of SP Energy Network's SP Distribution (SPD) and SP Manweb (SPM) service areas, covering both rural and urban networks. The networks are part of Deliverable 1.1 of the "D-Suite" Alpha phase Strategic Innovation Fund project. That project focused on exploring the potential of low voltage Power Electronic Devices (PEDs, such as Soft Open Points, STATCOMs, Smart Transformers), and so the networks include candidate locations for those devices.

See readme_networks.md for more details on the use and construction of these models.

The networks include:

both interconnected (meshed) and radial network topologies;
link boxes (i.e., the normally open/normally closed points of the network);
validated transformer ratings and impedances;
an explicit "one load to many customer" characteristic (as is common in urban areas when there are, for example, blocks of flats - see 'ncl_bus_connection_censored.csv' in the companion dataset "D-Suite Substation Modelling: LCT Profile Allocations" for a sanitised list of unique property reference numbers (UPRNs) to load buses)
Sample time series data over one calendar year to run with the networks (also from the same companion dataset).
Acknowledgment: This work was funded by the Ofgem Strategic Innovation Fund. D-Suite Alpha is project reference number 10086622 and is led by SP Energy Networks.

Attribution: These models are licensed under a Creative Commons - BY 4.0 licence, they can be referenced as "M. Deakin, 'Six UK-based Low Voltage Distribution Network Models', 2025, DOI: 10.25405/data.ncl.27175317"