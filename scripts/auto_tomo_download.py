from cryoet_data_portal import Client, Run, Tomogram
import sys
import os

client = Client()

# IDs for run to download
datasetid = sys.argv[1]
runid = sys.argv[2]

# set dataset directory
home = os.environ['HOME']
dataset_dir = os.path.join(home,'segmentation_data/raw_tomograms','dataset_'+datasetid)
annotation_dir = os.path.join(home,'segmentation_data/annotations','dataset_'+datasetid)
# create dataset and annotation directories if they don't exist and move into dataset dir
os.makedirs(dataset_dir, exist_ok=True)
os.makedirs(annotation_dir, exist_ok=True)
os.chdir(dataset_dir)
# get correct run and download it
run = Run.find(client, query_filters=[Run.id == runid, Run.dataset.id == datasetid])[0]
tomoid = run.tomogram_voxel_spacings[0].tomograms[0].id
tomogram = Tomogram.get_by_id(client, tomoid)
tomogram.download_mrcfile()

# rename file
new_file_name = 'run_'+runid+'.mrc'
os.rename(tomogram.name+'.mrc',new_file_name)