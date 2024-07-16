# About
This repository hosts the necessary scripts to create labeled data for tomograms to be used in model training. This data can range from segmenting entire bacteria to labeling flagellar motors.
### Contents
- Conda environment setup
- ITKSnap set up (segmenting program)
- File conversion scripts
- Conventions for data names/organization
- Scripts to convert data between file types
- Instructions for storing data on the supercomputer

### What you need
- Conda/mamba
- Python
- ITK-SNAP (Download [here](http://www.itksnap.org/pmwiki/pmwiki.php?n=Downloads.SNAP3))

# File Conventions for Segmentation Data
Please do your best to follow the below conventions so all the data can stay organized. They're not set in stone, but we do need to make sure we stay on the same page.

### File Structure for Annotation Data
Note: the `env_setup.sh` script should auto-build these directories. They *will not* end up in the GitHub repo, as tomograms are too big to store there. So, don't worry that these files do not show up on the repository. We will primarily be storing the files on the supercomputer. More on that later.
$HOME/  
├── segmentation_data/  
│   ├── raw_tomograms # directory to hold raw image files. Does not need to be uploaded to the supercomputer  
|   |   ├── dataset_1/  
│   │   |   ├── <tomogram_1>.mrc  
│   │   |   ├── <tomogram_1>.mha  
│   │   |   ├── <tomogram_2>.mrc  
│   │   |   └── <tomogram_2>.mha  
│   ├── annotations/ # directory to hold the annotations we create. Does need to be uploaded to the supercomputer  
|   |   ├── dataset_1/  
│   │   |   ├── <annotation_1>.mha  
│   │   |   ├── <annotation_2>.mha  
│   │   |   └── <annotation_3>.mha  

### File Names
Raw images are automatically downloaded and renamed to run_<runID>.mrc and converted to run_<runID>.mha. They are saved in the directory dataset_<datasetID>. All IDs correspond to the CZI database IDs.

Annotations should be saved following the pattern <annotation_type>_<runID>. For example, a membrane segmentation from dataset 10084, run 6100 would be saved as segmentation_data/annotations/dataset_10084/membrane_6100.mha (or whatever file type you chose to save as).