//
//  MovieItemView.swift
//  UIParallaxMovies
//
//  Created by Luiz Araujo on 08/03/23.
//

import SwiftUI

struct MovieItemView: View {
    let screenSize: CGSize
    let width: CGFloat
    let movie: Movie



    var body: some View {
        GeometryReader { reader in
            
            let midX = reader.frame(in: .global).midX
            let distance = abs(screenSize.width / 2 - midX)
            let damping = CGFloat(4.5)
            let percenage = abs(distance / (screenSize.width / 2) / damping - 1)

            VStack {
                Image(movie.imgString)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                    .shadow(color: .black.opacity(0.6), radius: 14, y: 10)

                Text(movie.title)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .padding(.bottom, 10)

                // MARK: Star Rating
                HStack(spacing: 5) {
                    ForEach(1..<6) { i in
                        Image(systemName: i <= movie.rating ? "star.fill" : "star")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .scaleEffect(percenage)
        }
        .frame(width: width)
        .frame(maxHeight: .infinity)
    }
}

struct MovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
