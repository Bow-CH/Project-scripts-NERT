import qupath.lib.regions.RegionRequest
import ij.process.ImageStatistics as Stats
import qupath.lib.images.servers.ImageServer
import qupath.lib.objects.PathAnnotationObject

// Access the current image data
def imageData = getCurrentImageData()
def server = imageData.getServer()

// Define the downsample factor (1 = full resolution, higher values for faster processing but lower resolution)
def downsample = 1

// Get all annotations in the current hierarchy
def annotations = getAnnotationObjects()

// Check if there are any annotations
if (annotations.isEmpty()) {
    print("No annotations found.")
    return
}

// Initialize lists to store results
def annotationNames = []
def averageIntensities = []
def standardDeviations = []

// Loop through each annotation and calculate statistics
for (annotation in annotations) {
    def roi = annotation.getROI()
    
    // Check if the annotation has an ROI
    if (roi == null) {
        print("Annotation has no ROI, skipping...")
        continue
    }
    
    // Create a RegionRequest to specify the ROI and downsample factor
    def request = RegionRequest.createInstance(server.getPath(), downsample, roi)
    def bufferedImage = server.readBufferedImage(request)
    
    // Convert BufferedImage to ImagePlus
    def imp = new ij.ImagePlus("temp", bufferedImage)
    
    // Calculate statistics including mean and standard deviation
    def stats = imp.getStatistics(Stats.MEAN | Stats.STD_DEV)
    
    // Store results in lists
    def annotationName = annotation.getName() ?: "Annotation ${annotations.indexOf(annotation) + 1}"
    annotationNames.add(annotationName)
    averageIntensities.add(stats.mean)
    standardDeviations.add(stats.stdDev)
}

    // At this point, the lists contain all the data
    // Print each list with items on separate lines
    
    println("Annotation Names:")
    annotationNames.each { println(it) }
    
    println("\nAverage Intensities:")
    averageIntensities.each { println(it) }
    
    println("\nStandard Deviations:")
    standardDeviations.each { println(it) }