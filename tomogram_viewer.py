import napari as nap
import mrcfile as mrc
import sys

tomogram = sys.argv[1]
with mrc.open(tomogram, permissive=True) as f:
    tomo = f.data

view = nap.Viewer()

view.add_image(tomo, name='tomo', scale=(1, 1, 1), colormap='gray')
nap.run()