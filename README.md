Data Visualization Project: Visualizing the number of contagious disease cases in the US between 1928 and 2011, broken down by state, disease, and time.
Project Overview: Contagious Disease Visualization Dashboard
Objective: Develop an interactive tool to communicate the historical trends of contagious diseases in the US, allowing users to explore patterns by state, disease, and time.
Approach:
Data Understanding: I began by acquiring a comprehensive dataset spanning from 1928 to 2011, which included information on disease cases, states, and corresponding timeframes. This involved cleaning and preprocessing the data to ensure accuracy.
Interactive Design: To engage users effectively, I decided to create an interactive application using R. I employed the Shiny framework, utilizing widgets such as selectizeInput, checkboxGroupInput, and sliderInput to enable user-driven exploration.
Visualization Techniques: Leveraging R's ggplot2 library, I crafted a line plot (plotOutput) to dynamically showcase disease trends. The accompanying verbatimTextOutput widget provided users with aggregated case numbers for selected diseases, offering a succinct summary.
Tools Used:
Programming Language: R was the primary language for this project due to its strong capabilities in data analysis and visualization.
Libraries: The ggplot2 library for data visualization and the Shiny framework for developing the interactive application.
Outcomes and Impact:
The application successfully communicated the evolving landscape of contagious diseases in the US. Users could explore trends, identify patterns, and understand the impact of vaccination campaigns on disease prevalence.
