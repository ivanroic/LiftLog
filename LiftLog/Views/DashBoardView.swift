//
//  DashBoardView.swift
//  LiftLog
//
//  Created by MacbookPro on 5/17/22.
//

import SwiftUI
import SwiftUICharts

struct DashBoardView: View {
    var body: some View {
        VStack{
            Spacer()
            //Line Chart
            LineChartView(data: [12, 22, 6, 1, 10], title: "Line Chart")
            Spacer()
            
            //Bar Chart
            BarChartView(data: ChartData(values: [("Jan", 12), ("Feb", 10),("Mar", 2),("Apr", 15),("Jul", 10),("Dec", 4),]), title: "Bar Chart")
            Spacer()
            
            //Pie Chart
            PieChartView(data: [12, 22, 6, 1, 10], title: "Pie Chart")
            Spacer()
        }
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
    }
}
