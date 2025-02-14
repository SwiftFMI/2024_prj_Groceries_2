//
//  ExploreVIew.swift
//  Groceries
//
//  Created by Lazar Avramov on 14.02.25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreVIew: View {
    @State var exploreCategory:ExploreCategory
    var body: some View {
        VStack{
                    
            WebImage(url: URL(string: exploreCategory.image ))
                .resizable()
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 120, height: 90)
                    
                
            Spacer()
            
            Text(exploreCategory.name)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    
            Spacer()
                    
                }
            .padding(15)
            .frame(width: 200,height: 150)
            .background(Color.paleGreen)
            .cornerRadius(16)
            .overlay (
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                )
            }
}


struct ExploreVIew_Previews: PreviewProvider {
    static var previews: some View {
        ExploreVIew(exploreCategory: .init(name: "Fruits",
                                           image: "https://www.healthyeating.org/images/default-source/home-0.0/nutrition-topics-2.0/general-nutrition-wellness/2-2-2-3foodgroups_fruits_detailfeature.jpg?sfvrsn=64942d53_4"))
        
    }
}
