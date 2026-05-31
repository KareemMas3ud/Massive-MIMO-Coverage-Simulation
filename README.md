<div align="center">

# 📡 Performance Analysis of Massive MIMO Systems

### Efficiency, Signal Processing, and Cell-Free Architectures

[![MATLAB](https://img.shields.io/badge/MATLAB-R2022b%2B-0076A8?style=for-the-badge&logo=mathworks&logoColor=white)](https://www.mathworks.com/products/matlab.html)
[![License](https://img.shields.io/badge/License-Academic-green?style=for-the-badge)]()
[![5G NR](https://img.shields.io/badge/5G%20NR-Research-FF6F00?style=for-the-badge)]()
[![Massive MIMO](https://img.shields.io/badge/Massive%20MIMO-64%20APs-8E24AA?style=for-the-badge)]()

---

*An extensive research and simulation effort evaluating Spectral Efficiency (SE), Energy Efficiency (EE), and the transformative potential of Cell-Free Massive MIMO architectures for next-generation mobile networks (5G NR and beyond).*

</div>

---

## 📋 Table of Contents

- [Project Overview \& Objectives](#-project-overview--objectives)
- [Key Technologies](#-key-technologies)
- [Theoretical Background](#-theoretical-background)
- [Simulation Features](#-simulation-features)
- [Simulation Parameters](#-simulation-parameters)
- [Repository Structure](#-repository-structure)
- [How to Run](#-how-to-run)
- [Results \& Interpretation](#-results--interpretation)
- [References](#-references)
- [Credits \& Acknowledgments](#-credits--acknowledgments)

---

## 🎯 Project Overview & Objectives

This repository presents a comprehensive research and simulation framework for the **performance analysis of Massive MIMO (Multiple-Input Multiple-Output) systems**, a cornerstone technology underpinning 5G New Radio (NR) and future beyond-5G wireless networks.

The core objectives of this project are:

1.  **Evaluate SE–EE Trade-offs:** Quantitatively analyze the critical interplay between Spectral Efficiency and Energy Efficiency in large-scale antenna systems. As the number of antennas scales, diminishing returns in SE must be balanced against escalating circuit power consumption — a central design challenge formalized by works such as [Björnson et al. (2015)](http://arxiv.org/abs/1403.6150) and [Ngo et al. (2012)](https://arxiv.org/pdf/1112.3810).

2.  **Comparative Analysis of Signal Processing Algorithms:** Provide a rigorous comparative study of linear signal processing techniques for:
    - **Downlink Precoding:** Maximum Ratio Transmission (MRT) and Zero-Forcing (ZF) precoding.
    - **Uplink Detection:** Minimum Mean Square Error (MMSE) detection and deep learning-augmented methods, specifically the OAMP-Net architecture ([He et al., 2018](https://ieeexplore.ieee.org/document/8646357)).

3.  **Demonstrate Cell-Free Massive MIMO Superiority:** Through spatial coverage simulation, illustrate how a **distributed Cell-Free architecture** fundamentally eliminates the cell-edge dead-zone problem inherent to traditional co-located (Cellular) Massive MIMO topologies, delivering uniformly good service quality across the entire coverage area ([Ngo et al., 2017](https://ieeexplore.ieee.org/document/7917284)).

---

## 🔧 Key Technologies

| Technology | Role in Project |
|---|---|
| **MATLAB (R2022b+)** | Primary simulation and visualization platform. Leverages the App Designer (`uifigure`) framework for interactive GUI construction. |
| **Massive MIMO** | Core wireless technology under investigation — equipping base stations with a very large number of antennas ($M \gg K$) to simultaneously serve multiple user terminals ([Marzetta, 2010](https://ieeexplore.ieee.org/document/5595728); [Larsson et al., 2014](http://arxiv.org/abs/1304.6690)). |
| **Cell-Free Architectures** | Distributed deployment paradigm where $M$ geographically dispersed Access Points (APs) coherently serve all users without cell boundaries ([Ngo et al., 2017](https://ieeexplore.ieee.org/document/7917284); [Björnson & Sanguinetti, 2020](http://arxiv.org/abs/1908.03119)). |
| **Linear Signal Processing** | MRT, ZF precoding (downlink) and MRC, ZF, MMSE detection (uplink) — the workhorses of practical Massive MIMO implementations due to near-optimal performance with tractable complexity ([Lu et al., 2014](https://ieeexplore.ieee.org/document/6798744)). |
| **Deep Learning Detection** | OAMP-Net: a model-driven deep learning architecture that unfolds iterative detection algorithms into trainable neural network layers for enhanced MIMO detection ([He et al., 2018](https://ieeexplore.ieee.org/document/8646357)). |

---

## 📐 Theoretical Background

### Spectral Efficiency vs. Energy Efficiency

In Massive MIMO systems, adding more base station antennas provides **array gain** and **spatial multiplexing gain**, both of which improve Spectral Efficiency (bits/s/Hz). However, each additional RF chain incurs non-negligible circuit power consumption. The **Energy Efficiency** (bits/Joule) is therefore a quasi-concave function of the number of antennas — it increases initially but eventually saturates and declines as hardware power dominates:

$$\text{EE} = \frac{B \cdot \text{SE}}{P_{\text{tx}} + M \cdot P_{\text{circuit}} + P_{\text{fixed}}}$$

where $B$ is the bandwidth, $P_{\text{tx}}$ is the total transmit power, $M$ is the number of antennas, $P_{\text{circuit}}$ is the per-antenna circuit power, and $P_{\text{fixed}}$ accounts for baseband processing and backhaul. This fundamental trade-off is rigorously analyzed in [Björnson et al. (2015)](http://arxiv.org/abs/1403.6150) and [Prasad et al. (2017)](https://ieeexplore.ieee.org/document/7811130).

### Precoding & Detection Techniques

| Direction | Technique | Principle | Complexity |
|---|---|---|---|
| **Downlink** | Maximum Ratio Transmission (MRT) | Maximizes received signal power via conjugate beamforming. Fully distributed — each AP requires only local CSI. | $\mathcal{O}(MK)$ |
| **Downlink** | Zero-Forcing (ZF) | Nulls inter-user interference by projecting onto the null space of co-scheduled users. Requires centralized CSI. | $\mathcal{O}(MK^2 + K^3)$ |
| **Uplink** | MMSE Detection | Minimizes mean square error by jointly accounting for interference and noise. Near-optimal for large $M$. | $\mathcal{O}(K^3)$ |
| **Uplink** | OAMP-Net | Unfolds the Orthogonal Approximate Message Passing (OAMP) iterative algorithm into a deep neural network with trainable parameters per layer. Achieves near-MMSE performance with adaptive convergence. | Network-dependent |

### Cell-Free vs. Cellular Massive MIMO

| Aspect | Cellular Massive MIMO | Cell-Free Massive MIMO |
|---|---|---|
| **Topology** | Co-located array at a single base station | $M$ distributed single-antenna APs |
| **Power Allocation** | Full power $P_t$ from central BS | $P_t / M$ per AP (uniform power scaling) |
| **Coverage Profile** | Concentric decay — severe cell-edge attenuation | Spatially uniform — at least one AP is always nearby |
| **Macro-diversity** | None (single point of radiation) | Inherent — received power is a superposition from all APs |
| **95%-likely Throughput** | Dominated by cell-edge users | Up to **5× improvement** over small-cell systems ([Ngo et al., 2017](https://ieeexplore.ieee.org/document/7917284)) |

---

## 🖥️ Simulation Features

The repository includes a custom-built **MATLAB Graphical User Interface (GUI)** that performs real-time spatial coverage simulation and visualization.

### GUI Capabilities

- **Interactive Parameter Control:** Users can dynamically adjust the simulation area, number of Access Points, and total transmit power via input fields and trigger re-computation with a single button click.
- **Dual Heatmap Generation:** Simultaneously renders two coverage heatmaps — **Traditional Cellular** and **Cell-Free Distributed** — for direct visual comparison under identical system parameters.
- **Received Power Visualization:** Heatmaps display received signal strength in dB using the `turbo` colormap with fixed color limits (−120 dB to 0 dB) for consistent cross-scenario comparison.
- **AP Location Overlay:** Access Point positions are rendered directly on the heatmaps (▲ for the co-located BS; ★ for distributed APs) for spatial context.
- **Project Information Panel:** An embedded terminal-style panel displays project metadata, team members, and supervisory information.

### Coverage Comparison — Visual Results

<div align="center">

| Traditional Cellular Topology | Cell-Free Distributed Topology |
|:---:|:---:|
| Concentric power decay from the central BS.<br>**Severe attenuation at cell edges** (< −100 dB). | Uniform power distribution from 64 distributed APs.<br>**No dead zones** — coverage is spatially homogeneous. |

</div>

> **Key Observation:** The Cell-Free architecture trades the peak power concentration at the BS location for a significantly more **uniform received power floor** across the entire 1 km × 1 km service area, effectively eliminating the cell-edge problem that fundamentally limits Cellular Massive MIMO.

---

## ⚙️ Simulation Parameters

The following default parameters are configurable through the GUI:

| Parameter | Default Value | Description |
|---|---|---|
| **Coverage Area** | 1000 × 1000 m | Square service area centered at the origin |
| **Number of Access Points ($M$)** | 64 | Total antenna elements (co-located or distributed) |
| **Total Transmit Power ($P_t$)** | 1 W (0 dBW) | Aggregate transmit power budget |
| **Path Loss Exponent ($\alpha$)** | 3.5 | Governs signal attenuation with distance ($\propto d^{-\alpha}$) |
| **Grid Resolution** | 100 × 100 | Spatial sampling resolution for heatmap rendering |
| **Cell-Free Power Scaling** | $P_t / M$ per AP | Equal power distribution across all distributed APs |
| **Minimum Distance Guard** | 1 m | Prevents singularity in path loss computation at AP locations |
| **Random Seed** | 42 | Fixed seed for reproducible AP placement in Cell-Free mode |

### Signal Model

**Cellular (Co-located):** All $M$ antennas are at the origin. The received power at grid point $(x, y)$ is:

$$P_{\text{rx}}^{\text{cellular}}(x, y) = \frac{M \cdot P_t}{\left(\sqrt{x^2 + y^2}\right)^{\alpha}}$$

**Cell-Free (Distributed):** $M$ single-antenna APs are uniformly distributed. The received power is the superposition from all APs:

$$P_{\text{rx}}^{\text{cell-free}}(x, y) = \sum_{i=1}^{M} \frac{P_t / M}{\left(\sqrt{(x - x_i)^2 + (y - y_i)^2}\right)^{\alpha}}$$

---

## 📁 Repository Structure

```
Massive-MIMO-Coverage-Simulation/
├── Cell_Free_VS_Cellular.m          # Main MATLAB GUI — simulation entry point
├── references.bib                   # BibTeX bibliography (17 references)
├── Papers/                          # Reference literature and supporting figures
│   ├── MatLab.png                   # Screenshot of the GUI with simulation output
│   ├── An Overview of Massive MIMO Benefits and Challenges.pdf
│   ├── Massive MIMO An Introduction.pdf
│   ├── Massive MIMO survey and future research topics.pdf
│   ├── Special_issue_on_Massive_MIMO.pdf
│   ├── Benefits/                    # Papers on Massive MIMO benefits
│   ├── Challenges/                  # Papers on pilot contamination, hardware, etc.
│   ├── Cell-free/                   # Cell-Free Massive MIMO literature
│   ├── Signal Processing/           # Precoding & detection algorithm papers
│   └── System Efficiency/           # SE/EE trade-off papers
├── Performance_Analysis_of_Massive_MIMO_Systems__...pdf   # Project report
├── Project_Instruction.pdf          # Assignment specification
└── README.md                        # This file
```

---

## 🚀 How to Run

### Prerequisites

- **MATLAB R2022b** or later (required for `uifigure`, `uiaxes`, and `clim` support)
- No additional toolboxes are required — the simulation uses only core MATLAB functions.

### Execution

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/KareemMas3ud/Massive-MIMO-Coverage-Simulation.git
    cd Massive-MIMO-Coverage-Simulation
    ```

2.  **Open MATLAB** and navigate to the cloned directory:
    ```matlab
    cd('path/to/Massive-MIMO-Coverage-Simulation')
    ```

3.  **Launch the simulator:**
    ```matlab
    Cell_Free_VS_Cellular
    ```

4.  The GUI will open automatically and execute the default simulation. To modify parameters:
    - Adjust **Area Size**, **Number of APs**, or **Tx Power** in the input fields.
    - Click **`Run Simulation`** to regenerate the coverage heatmaps.

> [!NOTE]
> The function `MassiveMIMO_GUI()` is auto-invoked when the script runs. The simulation executes immediately upon GUI initialization with the default parameters.

---

## 📊 Results & Interpretation

The simulation produces two side-by-side contour heatmaps that reveal a fundamental architectural distinction:

### Cellular Massive MIMO (Left Panel)
- Exhibits **concentric circular contours** centered at the base station location (origin).
- Received power decays monotonically with distance following $P_{\text{rx}} \propto d^{-3.5}$.
- Cell-edge regions (corners of the 1 km² area) experience received power well below **−100 dB** — effectively constituting coverage dead zones.

### Cell-Free Massive MIMO (Right Panel)
- Displays a **distributed, multi-peaked coverage landscape** where each AP contributes a localized power hotspot.
- The superposition of 64 AP contributions creates a **relatively uniform power floor** across the entire service area.
- Minimum received power is significantly elevated compared to the Cellular case, confirming the **macro-diversity gain** of the distributed architecture.

### Engineering Insight

> The Cell-Free topology redistributes the same total power budget ($P_t = 1$ W) across $M = 64$ spatially separated APs, each transmitting at $P_t/M \approx 15.6$ mW. Despite each individual AP being substantially weaker than the centralized BS, the **spatial diversity** ensures that every user location benefits from proximity to at least several APs, resulting in a dramatically more equitable coverage distribution.

---

## 📚 References

This project draws upon foundational and state-of-the-art research in Massive MIMO theory, signal processing, and Cell-Free architectures. Key references include:

1. T. L. Marzetta, "Noncooperative Cellular Wireless with Unlimited Numbers of Base Station Antennas," *IEEE Trans. Wireless Commun.*, vol. 9, no. 11, pp. 3590–3600, Nov. 2010.
2. H. Q. Ngo, E. G. Larsson, and T. L. Marzetta, "Energy and Spectral Efficiency of Very Large Multiuser MIMO Systems," May 2012.
3. E. G. Larsson, O. Edfors, F. Tufvesson, and T. L. Marzetta, "Massive MIMO for Next Generation Wireless Systems," *IEEE Commun. Mag.*, vol. 52, no. 2, pp. 186–195, Jan. 2014.
4. L. Lu, G. Y. Li, A. L. Swindlehurst, A. Ashikhmin, and R. Zhang, "An Overview of Massive MIMO: Benefits and Challenges," *IEEE J. Sel. Topics Signal Process.*, vol. 8, no. 5, pp. 742–758, Oct. 2014.
5. E. Björnson, L. Sanguinetti, J. Hoydis, and M. Debbah, "Optimal Design of Energy-Efficient Multi-User MIMO Systems: Is Massive MIMO the Answer?" Mar. 2015.
6. H. Q. Ngo, A. Ashikhmin, H. Yang, E. G. Larsson, and T. L. Marzetta, "Cell-Free Massive MIMO Versus Small Cells," *IEEE Trans. Wireless Commun.*, vol. 16, no. 3, 2017.
7. H. He, C. K. Wen, S. Jin, and G. Y. Li, "A Model-Driven Deep Learning Network for MIMO Detection," *IEEE GlobalSIP*, pp. 584–588, 2018.
8. E. Björnson and L. Sanguinetti, "Scalable Cell-Free Massive MIMO Systems," *IEEE Trans. Commun.*, vol. 68, no. 7, pp. 4247–4261, Jul. 2020.

> The complete bibliography is available in [`references.bib`](references.bib).

---

## 👥 Credits & Acknowledgments

<div align="center">

### 🎓 Project Team

| Name | Role |
|---|---|
| **Kareem Mohamed** | Researcher & Developer |
| **Rawan Essam** | Researcher |
| **Rawan Habib** | Researcher |
| **Rawan Walaa** | Researcher |
| **Mahmoud Tarek** | Researcher |

---

### 🏫 Supervision

| Supervisor | Affiliation |
|---|---|
| **Dr. Mohammed Hammouda** | Course Supervisor |
| **Eng. Salma Samy** | Teaching Assistant |

</div>

---

<div align="center">

*This project was developed as part of the **Digital Communications** course — a research initiative exploring the frontiers of Massive MIMO for 5G NR and beyond.*

---

**⭐ If this repository was useful to your research, please consider giving it a star.**

</div>
