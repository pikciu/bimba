import WidgetKit
import SwiftUI
import Intents
import Domain

struct DepartureTimeView: View {
    let time: DepartureTime
    
    var body: some View {
        HStack {
            Text(time.line)
            Text(time.departure, style: .time)
                .foregroundColor(.white)
            Text(time.direction)
        }
        
    }
}

struct DepartureTimeView_Previews: PreviewProvider {
    static var previews: some View {
        DepartureTimeView(time: DepartureTimeFactory.create())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
