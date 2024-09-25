import qupath.lib.roi.RoiTools

// Get the selected annotations
def selectedAnnotations = getSelectedObjects().findAll { it.isAnnotation() }

if (selectedAnnotations.isEmpty()) {
    println("No annotations selected.")
} else {
    // Initialize a list to collect detections to convert
    def detectionsToConvert = []

    // Get all detections
    def allDetections = getDetectionObjects()

    // For each selected annotation, find detections within it
    selectedAnnotations.each { parentAnnotation ->
        def parentROI = parentAnnotation.getROI()
        // For each detection, check if its centroid is within the parent ROI
        def childDetections = allDetections.findAll { detection ->
            def centroidX = detection.getROI().getCentroidX()
            def centroidY = detection.getROI().getCentroidY()
            parentROI.contains(centroidX, centroidY)
        }
        detectionsToConvert.addAll(childDetections)
    }

    if (detectionsToConvert.isEmpty()) {
        println("No detections found within the selected annotations.")
    } else {
        // Create new annotations from the detections
        def newAnnotations = detectionsToConvert.collect {
            return PathObjects.createAnnotationObject(it.getROI(), it.getPathClass())
        }

        // Remove the original detections
        removeObjects(detectionsToConvert, true)
        // Add the new annotations
        addObjects(newAnnotations)
        println("Converted ${newAnnotations.size()} detections to annotations within the selected annotations.")
    }
}
