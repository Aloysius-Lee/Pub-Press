import UIKit
import MapKit

class StarbuckAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var user = UserModel()
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
