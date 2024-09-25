import qupath.lib.objects.PathAnnotationObject
import qupath.lib.scripting.QP

// Input number here for numBands and radiusMicrons
def add_rings(annotationClass="Positive", numBands = 20, radiusMicrons = 20.0) {
    def hierarchy = QP.getCurrentHierarchy()
    hierarchy.getAnnotationObjects().findAll{it.getPathClass().toString() == annotationClass}.each { pathObject ->
    //hierarchy.getAnnotationObjects().findAll{(it.getPathClass().toString() == annotationClass)&&(it.getName()=="C_50kD2")}.each { pathObject ->
        //parent = pathObject.getParent()
        parent = pathObject
        parentName = parent.getName()+"-"
        //parentName = pathObject.getName()+"-"
        pathObject.setName(parentName+"0")
        pathObjectROI = pathObject.getROI()
        objectClass = pathObject.getPathClass()

        // Expand the annotation iteratively
        for (i=1; i<=numBands; i++){
            j=i-1
            currentObjects = getAnnotationObjects().findAll{it.getName() == parentName+j.toString()}
            if (currentObjects.isEmpty()) { continue }
            currentObjects[0].setName(parentName+i.toString())        
            selectObjects{it.getName() == parentName+i.toString()}
            runPlugin('qupath.lib.plugins.objects.DilateAnnotationPlugin', '{"radiusMicrons": '+ -1*radiusMicrons+',  "removeInterior": false,  "constrainToParent": true}');
            currentObjects[0].setName(parentName+j.toString())
        }
        print(parentName)
    
        // Add an external band (its index is band+1)
        //ringHole = getAnnotationObjects().findAll{it.getName() == parentName+numBands.toString()}
        //ringROI = RoiTools.combineROIs(parent.getROI(), ringHole[0].getROI(), RoiTools.CombineOp.SUBTRACT)
        //ring = new PathAnnotationObject(ringROI, objectClass)
        //ring.setName(parentName+(numBands+1).toString())
        //addObjects(ring)
        // Generate the other rings
        //for (i=numBands; i>0; i--){
        for (i=0; i<numBands; i++){
            j=i+1
            toRingify = getAnnotationObjects().findAll{it.getName() == parentName+i.toString()}
            ringHole = getAnnotationObjects().findAll{it.getName() == parentName+j.toString()}
            if (ringHole.isEmpty()) { continue }
            ringROI = RoiTools.combineROIs(toRingify[0].getROI(), ringHole[0].getROI(), RoiTools.CombineOp.SUBTRACT)
            ring = new PathAnnotationObject(ringROI, objectClass)
            ring.setName(parentName+i.toString())
            addObjects(ring)

            removeObjects(toRingify,true)
        }
    }
    // FIXME Interestingly, the outer ring isn't constrained to the original parent object.
    // Not sure how to solve this but for measuring things within the rings, it is not a problem.
    // resolveHierarchy()
    fireHierarchyUpdate()
    resetSelection()
}

// Input number here! format ("Positive", numBands, radiusMicrons)
add_rings("Positive", 20, 20)