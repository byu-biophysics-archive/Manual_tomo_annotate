from cryoet_data_portal import Client, Run, Tomogram
import sys
import os
import time

client = Client()
# IDs for run to download
datasetid = sys.argv[1]
runid = sys.argv[2]

# change directory so the file is downloaded in the correct location
os.chdir('~/segmentation_data/raw_tomograms')
# create dataset directory if it doesn't exist
if not os.path.exists(os.getcwd()+'/dataset_'+datasetid):
    os.makedirs(os.getcwd()+'/dataset_'+datasetid)
os.chdir('dataset_'+datasetid)
# get correct run and download it
run = Run.find(client, query_filters=[Run.id == runid, Run.dataset.id == datasetid])[0]
tomoid = run.tomogram_voxel_spacings[0].tomograms[0].id
tomogram = Tomogram.get_by_id(client, tomoid)
tomogram.download_mrcfile()

# wait for the file to be downloaded
def wait_for_file(file_path):
    previous_size = -1
    check_interval = 0.25

    while True:
        if os.path.exists(file_path):
            current_size = os.path.getsize(file_path)
            if current_size == previous_size:
                break
            previous_size = current_size
        time.sleep(check_interval)

download_name = tomogram.name+'.mrc'
wait_for_file(download_name)

new_file_name = 'run_'+runid+'.mrc'
os.rename(download_name,new_file_name)