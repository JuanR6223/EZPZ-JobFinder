/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The annotation view representing multiple bike annotations in a clustered annotation.
*/
import MapKit

/// - Tag: ClusterAnnotationView
class ClusterAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -10) // Offset center point to animate better with marker annotations
        displayPriority = .defaultLow
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// - Tag: CustomCluster
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        if let cluster = annotation as? MKClusterAnnotation {
            let totalJobs = cluster.memberAnnotations.count

            image = drawCount(totalJobs)
        }
    }
    
    @objc func btnTapped(sender: UIButton!) {
        print("cluster tapped")
        //performSegue(withIdentifier: "jobsSegue", sender: Any?.self)
        //TODO: show tableView with clusterMembers and pass tapped cell's annotation back to the mapview
        }
    
    private func drawCount(_ count: Int) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
        return renderer.image { _ in
            // Fill full circle with wholeColor
            UIColor.blue.setFill()
            UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)).fill()

            if let cluster = self.annotation as? MKClusterAnnotation {
                // Finally draw count text vertically and horizontally centered
                let btn = UIButton(type: .detailDisclosure)
                rightCalloutAccessoryView = btn
                btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
                
                let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.white,
                                   NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
                let text = "\(cluster.memberAnnotations.count)"
                let size = text.size(withAttributes: attributes)
                let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
                text.draw(in: rect, withAttributes: attributes)
            }
        }
    }
}
