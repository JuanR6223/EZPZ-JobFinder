/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The annotation views that represent the different types of cycles.
*/
import MapKit

/// - Tag: UnicycleAnnotationView
class JobMarkerAnnotationView: MKMarkerAnnotationView {

    static let ReuseID = "jobAnnotation"
    var job: JobClass?

    /// - Tag: ClusterIdentifier
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = "job"
    }
    
    init(annotation: MKAnnotation?, reuseIdentifier: String?, job: JobClass?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        if let job = job {
            self.job = job
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultHigh
    }
}
