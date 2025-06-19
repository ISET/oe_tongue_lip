# Modeling Spectroradiometric Measurements of Oral Mucosal Autofluorescence

Joyce E. Farrell, Xi Mou, Brian A. Wandell
Stanford University

**Abstract**
This study explores the potential of quantitative autofluorescence imaging (AFI) as an objective tool for monitoring the health of oral mucosal tissue. Our approach involves acquiring spectroradiometric measurements of tissue fluorescence and utilizing a model to understand the fluorophores influencing these measurements, including the impact of blood attenuation. We acquired fluorescence measurements from the dorsal tongue and inner lip of healthy human volunteers, subsequently fitting the model to these data to estimate individual fluorophore contributions and the optical density of the blood. Our dataset and model, which are freely shared in an open repository, aim to advance the development of quantitative, non-invasive diagnostic imaging systems for monitoring oral health, ultimately facilitating the detection and characterization of oral mucosal tissue abnormalities.

The full paper is available at ...

## Computational
This repository depends on [ISETCam](https://github.com/ISET/isetcam/wiki) and [isetfluorescence](https://github.com/ISET/isetfluorescence/wiki). To run this code, please download those repositories and this one (oe_tongue_lip). Place these repositories on your path. 

The figures are pasted below.  To see the script we used to create the figures, click on the link on the figure number. 

## Figures

![image](https://github.com/user-attachments/assets/f664e6bf-cf8f-4ac1-968b-d7339ce37b81)

[Figure 1](https://htmlpreview.github.io/?https://github.com/ISET/oe_tongue_lip/blob/main/figures/oeFigure1_LightCalibration.html).  A, B: Geometry and filters for the light measurement. These panels depict the measurement of the excitation lights. The nominal wavelengths for the lights are 405 nm, 415 nm, and 450 nm, but their actual peak wavelengths are 408 nm, 416 nm, and 444 nm, respectively. To minimize unwanted long-wavelength light, the excitation lights pass through a 450 nm short-pass filter. The graph in panel B displays the spectral radiance of these excitation lights on a logarithmic scale.  C, D: Geometry and filters for the oral cavity measurement. These panels show the setup for measuring light from the oral cavity. This arrangement is similar to the light measurement setup, but a 475 nm long-pass filter is positioned in front of the spectroradiometer. The graph in panel D shows the spectral fluorescence emitted from the dorsal tongue when illuminated with a 415 nm excitation light, also on a logarithmic scale. Note that the measured wavelength range for fluorescence is 500-700 nm, and the fluorescence signal is approximately four orders of magnitude lower than the peak radiance of the excitation light. The 475 nm long-pass filter is crucial for blocking reflected excitation light, which enables the long exposure time needed to detect the weak fluorescent signal.


***


<img width="761" alt="image" src="https://github.com/user-attachments/assets/951dee0e-25af-4858-a6cd-c99517de3fd4" />

[Figure 2](https://htmlpreview.github.io/?https://github.com/ISET/oe_tongue_lip/blob/main/figures/oeFigure2_FluorescenceAndReflectance.html). 
Fluorescence signal compared to unwanted reflected light for a 415 nm excitation light. The solid
curves are fluorescent signals. The dashed curves are estimates of the reflected light. The symbols indicate the
subject. (A) Lip. (B) Tongue. The data are plotted on a logarithmic (log₁₀) scale to highlight the fact that the tissue
fluorescence levels exceeds the unwanted reflected light by an order of magnitude. Both tissue fluorescence
and reflectance show evidence of blood absorption with dips at 540 and 580 nm.


***

<img width="718" alt="image" src="https://github.com/user-attachments/assets/ff8fb00a-d060-46cd-815b-e905e14cf354" />

[Figure 3.](https://htmlpreview.github.io/?https://github.com/ISET/oe_tongue_lip/blob/main/figures/oeFigure3_GroupLights.html) 
Fluorescence measured with the three different excitation lights. Lines of the same color used the
same excitation light; within a color each curve is from a different subject. (A) Lip fluorescence. The data are
very similar, although there is more overlap in the fluorescence using 405 nm and 415 nm excitation lights. (B)
Tongue fluorescence. The data are very similar in the 500-600 nm, again with more overlap for the 405 nm and
415 nm excitation light. However, there is more variation between subjects in the fluorescence measured in the
600 - 700 nm band, which we explain in the analysis. All curves are scaled to 1 at 520 nm.

***

<img width="741" alt="image" src="https://github.com/user-attachments/assets/f793f166-d1e1-4d98-9383-d90d2b8962dd" />

[Figure 4.](https://htmlpreview.github.io/?https://github.com/ISET/figures/oeFigure4_TongueLip.html) Spectral radiance of dorsal tongue and inner lip oral mucosal tissue measured with excitation lights at
(A) 405/415 nm and (B) 450 nm. The data were acquired from four subjects on different days, different excitation
light intensities, and different locations on the dorsal tongue (solid line) or on the inner lip (dashed line). The
spectral radiance curves are scaled to 1 at 520 nm.


***

<img width="741" alt="image" src="https://github.com/user-attachments/assets/f273fe65-3842-4dbc-80a3-e3587048aa4d" />


[Figure 5.](oeFigure5_9_ModelFits.html) Model description. (A) Description of the spatial distribution of the fluorophores in the tongue and lip.
FAD, NADH, Collagen and blood are present in both. The tongue has an additional layer of cells with keratin, and
the surface may contain both porphyrin and chlorophyll-a. The chlorophyll-a can be present from residual food,
such as leafy vegetables. (B) The spectral emissions of the fluorophores. The collagen is illustrated after
transmission through the blood. Filtering by the blood creates the local minima near 540 and 577 nm.

***

<img width="578" alt="image" src="https://github.com/user-attachments/assets/8239513f-0c02-4b95-a50c-99b3b19dc9f5" />

[Figure 6.](oeFigure5_9_ModelFits.html) Tongue bulk fluorescence from the 405/415 nm excitation lights. Each panel shows a different subject.
The data include different excitation light intensities, different days and locations. The gray shaded curves are
measurements, scaled to 1 at 520 nm, and the dashed black curves are model fits.

***

<img width="578" alt="image" src="https://github.com/user-attachments/assets/f096de63-cad9-4253-b108-bfb603babbfd" />

[Figure 7.](oeFigure5_9_ModelFits.html) Lip bulk fluorescence from the 405/415 nm excitation lights. Each panel shows a different subject. The
curves include different excitation light intensities, different days and locations. The gray shaded curves are
measurements, scaled to 1 at 520 nm, and the dashed black curves are model fits.

***

<img width="663" alt="image" src="https://github.com/user-attachments/assets/d7cc24e2-463c-499d-bda6-5b3deed5d99f" />

[Figure 8.](oeFigure5_9_ModelFits.html) Tongue bulk fluorescence from a 450 nm excitation light. Each panel shows a different subject. The
curves include different excitation light intensities, different days and locations. The gray shaded curves are
measurements, scaled to 1 at 520 nm, and the dashed black curves are model fits.

***

<img width="663" alt="image" src="https://github.com/user-attachments/assets/c5741381-d62c-4321-8029-73bf3b8afba3" />

[Figure 9.](oeFigure5_9_ModelFits.html) Lip bulk fluorescence and model fits from a 450 nm excitation light. Each panel shows a different
subject. The curves include different excitation light intensities, different days and locations. The gray shaded
curves are measurements, scaled to 1 at 520 nm, and the dashed black curves are model fits.

***

<img width="774" alt="image" src="https://github.com/user-attachments/assets/6abdd6ff-be9c-4102-aaf9-6e38cadde6a4" />

<img width="774" alt="image" src="https://github.com/user-attachments/assets/6bd60f09-da31-4d9f-b6c8-b234da2324cb" />

