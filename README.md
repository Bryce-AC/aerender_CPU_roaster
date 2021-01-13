# aerender_CPU_roaster
Some cobbled together batch scripting to run multiple instances of aerender

## Instructions
1. Make sure there's a composition in the AE project called `render` which has been added to the render queue with the settings you desire  
I have included the .aom file template thing with the settings I typically use (it's just prores4444 with alpha enabled). 
2. Run the batch file, selecting the .aep file, entering the number of frames in the `render` comp and the number of core roasters you want
4. Run it and it'll produce two folders in the same directory as the .aep file, run the new batch files in the `core_roaster_render_scripts` folder
5. Now you can stitch the files in `core_roaster_render_output` together in your editor of choice
6. Profit

## Notes 
modifier ref: https://ss64.com/nt/syntax-args.html
