# Quick Topic Links:  
[[Advice to users|https://github.com/hsosik/ifcb-analysis/wiki/Instructions-for-manual-annotation-of-images#advice-to-users]]  
[[Getting Started|https://github.com/hsosik/ifcb-analysis/wiki/Instructions-for-manual-annotation-of-images#getting-started]]  
[[Configuration Editor|https://github.com/hsosik/ifcb-analysis/wiki/Instructions-for-manual-annotation-of-images#edit-configuration]]  
[[Manual Annotation|https://github.com/hsosik/ifcb-analysis/wiki/Instructions-for-manual-annotation-of-images#manual-annotation]]  
[[Output File Format|https://github.com/hsosik/ifcb-analysis/wiki/Instructions-for-manual-annotation-of-images#output-file-format]]  
[[Advanced User Topics|https://github.com/hsosik/ifcb-analysis/wiki/Instructions-for-manual-annotation-of-images#advanced-user-topics]]  
[[Troubleshooting|https://github.com/hsosik/ifcb-analysis/wiki/Instructions-for-manual-annotation-of-images#troubleshooting]]  


***

# **Summary:**

Manual annotation allows one or more people to specify class labels (e.g., taxonomic names or other identifying strings) and then select images that belong in each class. This can be used for class-specific data analysis (such as producing a time series of class-specific concentration or biomass) and is also necessary to produce training sets for supervised classification. 

The software system described here runs in MATLAB. It enables display of a series of images from IFCB ROI files (or from a series of image files such as those produced by the VPR or exported from FlowCAM output) and produces output files that map between images and class numbers / labels. At present, the output files record only the last annotation (class label) assigned to any image, so new class assignments will overwrite any previous ones (on an image-by-image basis).

Running **startMC** allows you to:  

1. Edit the configuration file required for manual classification of ROI files from IFCB images  
1. Manually annotate images  
1. Save result files of all annotations  

***  

# **Advice to users:**  
Assume there will be more than one user of an IFCB data set or time series. Even if starting with one user, future collaborators, graduate students or technicians may also contribute to image annotation, or lead associated side projects. With this assumption, everyone in the user group should work from the same class list and the same result files stored in a common location. Combining result files from two users after the fact will be tricky. In addition, always back up manual result files! Other IFCB data products (e.g., blob images, feature files) can be reproduced with computing time, but manual result files represent many hours of work that cannot be automatically reproduced.  

***  

# **Getting Started**  
1. If you have not already cloned the ifcb-analysis code repository, installed MATLAB, and configured paths in MATLAB, follow the instructions [here](https://github.com/hsosik/ifcb-analysis/wiki).  
1. Open MATLAB and type `startMC` on the command line.  

      > Hint: This will launch with the most recent configuration (if one exists). You can type `startMC(‘default’)` to force start up with the default configuration. You can also force start up with a specific saved configuration by inserting the saved configuration file name: e.g., `startMC(‘your_config_path and_filename_here’)` or, if your file is saved in the default path or most recently used path, `startMC('your_filename_here')`.

1. A small window will open with three buttons: [Edit Configuration](#edit-configuration), [Start Manual Classify](#manual-annotation), and [Quit](#quit). Click on Edit Configuration.  
##### startMC panel
![startmcsmaller](https://cloud.githubusercontent.com/assets/14059636/19080109/001e2a08-8a24-11e6-84ed-0324447811bc.png)

>Hint: If you started with a previous configuration, you can skip Edit Configuration and proceed directly to [Manual Annotation](#manual-annotation), if desired.

> Note: When startMC is running, the startMC window will remain open though its buttons will be inactive any time you have either the Edit Configuration or the Manual Classify window open. You will also see the original MATLAB window with command prompt, but that instance of MATLAB is busy running startMC and it cannot effectively be used for any other operations (until you Quit from startMC). You can launch another instance of MATLAB if you need to use MATLAB at the same time as startMC. 

***  

# **Edit Configuration**

These instructions assume a blank slate in the configuration editor (default configuration), or that you have not previously used Manual Classify on your computer. At any time, you can return to the default configuration from the configuration editor menu:  **File -> Reset default configuration (Ctrl +R).** 
> Note: If you already have a saved configuration file, proceed to [Saving and Loading Configuration Files](#saving-and-loading-configuration-files)

#### ManageMCConfig example
![cofiguration editor](https://cloud.githubusercontent.com/assets/14059636/19083319/adee7c22-8a2f-11e6-9181-7b6cbb4b44d5.png)


### **Display Settings (Blue panel in the configuration editor):**
#### **Display images by size**  
Check this option to display images within each class by size (images with largest y-dimension will be shown first). Otherwise images will be displayed in the order in which they were acquired (lowest ROI number first).

#### **Images in a set**  
This defines the largest number of images that will be loaded at one time. 
> For example, if there are 1200 images in one class and **Images in a set = 200,** the annotation software will load the images in six sets of 200. This can be helpful for reducing loading time, or jumping to the middle of a class containing many images. 
***
> Choose a very large number (e.g., 20000) if you want all images in a class to load at once.

#### **Image scale factor**  
Select a linear scaling factor, where values >1 show images larger than their original pixel resolution size and values <1 show them smaller. Default = 1 shows unscaled images and is almost always acceptable. 
>  This feature is most useful if viewing very large or small images, and especially if viewing small images on a small or high resolution screen such as a laptop. Any decimal value >0 is acceptable (though if you choose a very large number, some images may be only partially displayed if the scaled version is larger than the pixels available on your screen).  

#### **Show**  
Select from a drop down menu to define a size range of images to view.  
Choose **All** (default) to display all images in a file, irrespective of image size.  
If **Larger** or **Smaller** is selected, additional boxes will appear to enter ROI size thresholds. 
> This feature is most useful if you are only interested in analyzing certain classes that you know are always above or below a given size threshold. Good record keeping is important for further analysis of any data files annotated with size thresholds in place.  
***
>Hint: You can always complete annotations with a size threshold enabled and then do a second round reviewing the images with the threshold disabled to make any additional missed annotations.  

#### **Verbose mode**  
Checking or unchecking Verbose mode does not affect the function of Manual Classify. If working in Verbose mode, more information about class and set progress is displayed in the MATLAB command window.  

#### **Max in left category list**  
The class list extends along the left side, and if desired also along the right side, of the screen. The list starts on the upper left side. If the list is longer than the screen height, it will be displayed with a scroll bar. You may limit the number of classes displayed on the left side by setting the **Max in left category list** value; the remaining classes in your list will then be displayed along the right side. 

>Hint: Since scrolling can be inefficient, it is generally best to split long lists between the left and right sides of the screen. The number of classes that fit in a pane without scrolling depends on screen size and resolution and **font size** setting.

#### **List font size**  
Set the point size of the text in the class list panes. The default value (8) usually works well.  

#### **Default category**  
Select from a pull down list to specify a class label. If you are starting from unclassified files, all of your images will start out in this default category. Any images that are not annotated will be labeled with the default category number in the manual result files. It is not advisable to change the default category within a data set.  

>Hint: It can be helpful to include a miscellaneous class label (e.g., 'other') in your category list and to use that as your default. It can also be efficient to set the default class to the image type most common in a dataset (e.g., 'miscellaneous nanoplankton').   

#### **Scale bar length**  
Enter a number specifying the length (in micrometers) of the scale bar to be shown with each panel of images. 

#### **Pixels per micron**  
Enter a number that specifies how many pixels correspond to each micrometer of length in your images.  
>Hint: You can derive an estimate for your instrument by imaging known-sized cells and/or beads. Keep in mind that the optical halo around cells and beads may differ and that conversion will depend on image quality (focus).  

#### **Alphabetize category list**  
If checked, the class selection list will display in alphabetical order.
If unchecked, the list will display in order of class numbers. 

### **File selection ([green panels](#managemcconfig-example) in Manage MCconfig)**  
In this section you will configure all of the paths (folders) and select files to annotate. Your selections will be displayed in the green panel on the right side of the window. If your selections are displayed in red text, your path/file combinations cannot be found at the specified drive location.  
>Hint: You will not be able to annotate images if you see selected path/file combinations that appear in red text. Double check and appropriately modify your file locations until all the text is black.  

#### **Manual result path**  
Browse to select the location where your manual files are or will be stored. Ideally, this should be a common location shared with other users in your lab/group.  
>Hint: You may also type or copy/paste a drive location directly in the text box.  

#### **File selection**  

1. Choose a file selection mode. Pick either **Select ROI files** (use this option if you want to choose one or more raw data files to annotate) or **Select existing manual files** (generally use this option if you want to continue working with files that are already partially annotated).  
>Note: The behavior of the Manual Classify module does not depend on which method you use to choose one or more files to annotate. Use whichever file selection mode seems most convenient.

1. Choose one or more files to annotate. Either check the **All files in chosen path** box or click the **Browse** button to select files from a listing of files on disk. The latter option opens a new window showing all files available in the selected drive location; click on one file OR use shift-click to select multiple consecutive files OR use ctrl-click to select multiple non-consecutive files.  

>Hint: You may wish to avoid using the **All files in chosen path** option if you have a very large number of files in the same drive location. This can lead to delays in checking the status of all files during configuration stages.  
***
>Hint: After you select some files, you may add more to your list by clicking the button now labeled **Select more files.**  
***
 >Hint: You may clear your list of selected files at any time, by clicking **Clear all files.**  

Once files are selected, they should appear with their corresponding paths in the green panel on the right. Both the *Manual result files* and associated *Image files* will appear. When all of the paths are correct, files will be listed with black text. Red text indicates folder/file combinations not found on disk; this is an error that must be corrected before manual classification can be done.   

#### **Start from classifier**  
If you have already run an automated classifier on your data, you may wish to start from those results and use manual annotation to correct any errors or further refine broad or mixed group classes. To enable this option, click the box next to **Start from classifier** and then browse to the correct **Class file path**. Note that a third box in the right hand green panel should also appear and list the corresponding class files.  

### Creating or loading a **Category List** ([pale orange panel](#managemcconfig-example) in Manage MCconfig)
You need to create or load an existing list of class labels. It is advisable to use the _same list within one lab group_ and share the list and alert others if you are adding to the list. Once your list is established, always add to the end of it, not to the beginning or the middle.  

#### **Load/Edit**  
This button will open the **Manage Class Labels** window where you can either type in a new class list or load / save a list from a file. Use the **Add class to end of list** button to enter new class labels. If you need to change a label (e.g., correct a spelling error), select the **Edit existing class** check box and then edit directly in the cell of the label you wish to change. 
>Note: Change existing labels with caution, if you have annotations already stored with the old label. 

Once your list is complete, save it and click the **Back to MCconfig** button. The **Manage Class Labels** window will close. 

#### **Highlight categories to view**

After your class list is loaded, select the categories you wish to view in the Manual Classify window. Most commonly, check the highlight all box (default).
 
If you wish to de-select individual categories, use Ctrl+click. 

If you wish to select only one or a few categories, uncheck the **highlight all** option and select individual categories with Ctrl+click (or Ctrl+Shift+click to select consecutive entries from the list). 

At least one category must be highlighted to proceed with manual classification.  

### Saving and Loading Configuration Files
From the File menu in the [**Edit Configuration**](#managemcconfig-example) window, you can save configuration settings to a file. From the same menu, saved configurations can be loaded from a file at the start of the next session. After loading a file, make any desired changes in settings as described in [Edit Configuration](#edit-configuration) and save the revised settings if desired. 

### Close the Configuration Editor
Once your configuration settings are complete, press the **Return to startMC** button. The configuration editor window will close (unless you have not saved your configuration, in which case you will be prompted to do that first). You are now ready to proceed to [**Manual Annotation**](#manual-annotation). 
***
# **Manual Annotation**  
Once a configuration has been loaded from a file or manually defined in [Edit Configuration](#edit-configuration), annotations can be made. 

From the [startMC panel](#startmc-panel), click the **Start Manual Classify** button. The full screen [Manual Classify window](#manual-classify-window-example) should appear. 

There are a number of ways to set up and efficiently make annotations. The sections below provide a few important points and a description of the simplest case.

>Some terminology:
>
>**Current class** = The currently viewed class. The class label is displayed in red text across the top of the image mosaic. 
>
>**Destination class** = Class to which you are moving ROIs. This is the selected class in the numbered category list along the left side of the screen (or in the continuation on the right side if your list is longer than **max in left category list** as set in the configuration). 
>
>**Class = Category** (used interchangeably)  

#### **Important features of Manual Classify:**  
* Your entire class list appears in red along the left (and possibly right) of the screen. Use this to select the destination class when annotating images. If your list is long enough, the box will appear with a scroll bar.   
* Name of the current class and file in red at the top of the screen.  
* Images in the current class are displayed within the central axes (and show up on more than one screen if necessary).  
* Menu options appear along the upper left of the screen.  

##### Manual Classify window example
![manual classify screen edited outlining](https://cloud.githubusercontent.com/assets/14059636/19086194/27d4d4d6-8a3b-11e6-81ca-95a8a284589d.PNG)  

#### **Basic operation of Manual Classify:**  
* Select a destination class by clicking on a class within the list. The selected class will be highlighted blue.  
* Click on one or more images that you wish to assign to the destination class. You may click anywhere within a ROI box to include it. When you are done selecting, press the **Enter** key to store those results. Little red numbers corresponding to the destination class will appear in the location of every click. 
* If desired, choose a new destination class and repeat the previous step.   
* To advance to a new page of images, press the **Enter** key. Usually, this will mean pressing **Enter** twice in a row, once to record the most recent set of image clicks and a second time to advance to the next page of images. There may or may not be more than one page of images in the current class. If not, then the next class will be displayed. 
* To return to a previous screen, press the left arrow (**&larr;**) key followed by the Enter key.  

>In the case that a *left arrow, Enter* key sequence is pressed to return to a previous class, pages will be displayed again from the start of that class.  

* Whenever you advance to the next class (or switch current class by any other approach, see below), the clicked images with red numbers will be relocated to appear in their new destination categories. The annotation information is saved in the manual result file every time you hit the Enter key after initially clicking the ROIs, but the screen views are only updated to reflect the new assignments when you change the current class being viewed.  

 > At any time, you can change the class assigned to an image by selecting a different destination class and clicking on the ROI, even if you have already clicked that same ROI once or more). For example, if the same ROI is clicked twice before changing current class, two red numbers will still be displayed on the ROI, but the stored results will reflect only the last destination class selected.   


#### **Additional functions available in the menus (or via Ctrl+ hotkey sequences):**  

> Warning: The hotkey designations are reliable in MATLAB running under MSWindows, but seem to be bug prone under current Mac OS installations. 

1. Change class:  
  *  Next class (or Ctrl+N): Advance the current class to the next one in the category list.
  *  Previous class (or Ctrl+P): Revert the current class to the previous one in the category list.  
  *  Jump to selected class (or Ctrl+J). This is the only case in which the blue highlighted class is associated with the class to view instead of the destination class for annotations. Click on the class to jump to and press Ctrl +J. Now the class selected from the list will be the new current class and should appear in the label above the image mosaic as usual. 

> If the user requests a jump to a class that contains no images, the jump will be aborted. The current class will not change and a red text note along the bottom of the display will indicate that the jump was not made since the requested class is empty. 

> If the user requests a change to next or previous class, any classes that contain no images will be skipped. The new current class displayed will be the next one in sequence (forward or backward) that contains images to display. 

> If the user requests a change to the previous class while the first class is already the current class, no change will be made. If the user requests a change to the next class while the last class is already the current class, the display will advance to the start of the next file.

1. Change file:  
 * Next File (or Ctrl+L): Move to the next file in the list in the configuration file.  
 * Previous File (or Ctrl+K): Move to the next file in the list in the configuration file.  
 * Jump to selected file (or Ctrl+M): Open a list of all of files (specified during configuration) and move to the one selected by the user. 

1. Change set: 
 * This menu option is only available if there is more than one set in the current class. This will depend on your set size in the configuration file and the number of images in a class. Choose the set you wish to display by selecting from the drop down menu that shows the consecutive numbers of the first image in each set.   

1. Options: 
 * This menu item allows the user to make on-the-fly changes to some the same options that are set in the configuration editor. These changes only apply during the current session (change them in the configuration editor if you want them to be saved for future sessions). 

> Note: After editing **Options**, the current class will be displayed starting from the first page of images.   

#### **SELECT All** buttons on [Manual Classify screen](#manual-classify-window-example) 

1. **SELECT all page**. The rectangle around “SELECT all page”, to the upper left of the displayed ROIs, functions similarly to selecting a single ROI. Click on a destination class and then click anywhere within the grey box around “SELECT all page”; press “Enter” and a red number (indicating the destination class) will appear there. **This is equivalent to clicking on every ROI on the page individually.**
  
1. **SELECT remaining in class**. For this case, select the destination class, and then click the **SELECT remaining in class** button (to the left of the text). In this case, the ROIs on the current page and all subsequent pages of the current class will be moved to the destination class. NOTE: No ROIs on previous pages of the class will be affected. 

If these SELECT all features are used effectively, they can save a lot of time spent clicking. If more than half the ROIs on a page need to be moved to the *same* class, use select all. Then, continue with separate destination classes and ROI selections to correct any cases that you did not want to include in the select all operation. **Remember**, only that last destination class selected for a ROI is stored in the result file. 

For example: When viewing class “_Chaetoceros_”, you see some _Chaetoceros_, but more chains of _Thalassiosira_. _Thalassiosira_ will be your destination class.  

1. Select _Thalassiosira_ in the list of classes (destination class).  
1. Click “SELECT all page” and press “enter”.  
1. Select _Chaetoceros_ in the list of classes (current class).  
1. Click on all of the _Chaetoceros_ and press enter so that they remain in the current class and do not get moved to _Thalassiosira_.  
1. If you want to check to see if you missed any _Chaetoceros_, jump (ctrl+J) to _Thalassiosira_ and look for mistakes. Then jump back to _Chaetoceros_ to continue viewing all classes in order.  

Once again, this is a good time to experiment with the available options, and see what is most efficient for you and your dataset.  

## Quit
Clicking the **Quit** button from the [startMC panel](#startmc-panel) closes the panel and returns to the MATLAB command prompt. If the **Quit** button is grayed out, ensure that you have already quit from the Edit Configuration and Manual Classifications windows.

# Output File Format

Manual Classification results are stored in individual mat files, one for each original ROI file, with the same name as the original data file, except with the .mat extension (e.g. raw data D20141117T000015_IFCB102.roi; manual results D20141117T000015_IFCB102.mat). We recommend that all manual output files for a data set are stored in a single location that is shared among users of the data set. 

The manual result mat files contain the following variables:

_class2use_manual_ : vector of class labels

_default_class_original_ : label for class chosen as default when manual annotations were started (if not started from an automated classifier)

_list_titles_ : column labels for _classlist_

_classlist_ : matrix containing annotation results, one row for each image (ROI)
  *  column 1: ROI number in the original IFCB data file
  *  column 2: Class (index number in class2use_manual) assigned manually; NaN if no manual annotation made
  *  column 3: Class assigned by an automated classifier used for initial annotation

***During display in Manual Classify, column 3 is assumed to be verified as correct, if column 2 contains NaN; otherwise column 2 is correct and column 3 is ignored.*** 

# Advanced User Topics

**SECTION UNDER CONSTRUCTION

## Command line input of a list of data files

## Replacing classifier results with output from a new automated classifier

## What else?

***
# **Troubleshooting**  

#### * Some items appear off the top, bottom, or sides of the ManageMCconfig or the Manual Classify window  

1. Quit manual classify and Exit from MATLAB. 
1. Adjust your screen resolution to the highest resolution available.
1. In MSWindows, ensure that your display options have "size of text, apps, and other items" set to 100% (or less).    
1. Open MATLAB again and run startMC. 

#### * Errors occur that prevent the Edit Configuration screen successfully displaying  

1. Restart with the default configuration: **startMC('default')**  
1. Then load and edit an existing configuration, if desired ([Saving and Loading Configuration Files](#saving-and-loading-configuration-files)).

#### * Nothing happens when I click the **Start Manual Classify** button from the startMC panel.  

1. Return to the Edit Configuration panel and make sure one or more categories are highlighted (for display) in the class list pane.  
1. If the problem persists: You may have no images to display in the selected categories. This will be reported on the MATLAB command line with the message “No images in class:”. Return to Edit Configuration and choose new categories or new ROI files. 

#### * Somehow I got errors and now I cannot close one or more of the startMC windows. The *Quit* options do not work. 
1. On the MATLAB command line where you originally typed `startMC`, now type `close all force`. 
2. After all the windows close, type `startMC` on the command line to try again.  
***
