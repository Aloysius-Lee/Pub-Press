

import UIKit
import MapKit

class StarbuckAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var pub = PubModel()
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
