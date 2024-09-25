import qupath.lib.regions.RegionRequest
import ij.process.ImageStatistics as Stats
import qupath.lib.images.servers.ImageServer

// Check if there is an ROI selected
def roi = getSelectedROI()
if (roi == null) {
    print("No ROI selected. Please select an ROI to proceed.")
    return
}

// Access the current image data
def imageData = getCurrentImageData()
def server = imageData.getServer()

// Define the downsample factor (1 = full resolution, higher values for faster processing but lower resolution)
def downsample = 1

// Create a RegionRequest to specify the ROI and downsample factor
def request = RegionRequest.createInstance(server.getPath(), downsample, roi)
def bufferedImage = server.readBufferedImage(request)

// Convert BufferedImage to ImagePlus
def imp = new ij.ImagePlus("temp", bufferedImage)

// Calculate statistics including mean and standard deviation
def stats = imp.getStatistics(Stats.MEAN | Stats.STD_DEV)

// Print the average intensity and standard deviation
println("Average intensity within ROI: ${stats.mean}")
println("Standard deviation within ROI: ${stats.stdDev}")