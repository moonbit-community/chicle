# Prototype the DOM Projection

Type: prototype
Status: resolved
Blocked by: 03

## Question

What is the smallest DOM Projection that makes nested Chicle geometry legible across flex, grid, absolute positioning, overflow, and zero-sized nodes without allowing browser layout or label measurement to alter the computed result?

## Answer

Each result node becomes a nested absolutely positioned DOM box using its parent-relative location and computed size. Outlines and overlaid labels do not affect box dimensions. The root surface is uniformly scaled and centered to fit the preview viewport.
