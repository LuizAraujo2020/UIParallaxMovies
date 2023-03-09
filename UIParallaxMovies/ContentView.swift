//
//  ContentView.swift
//  UIParallaxMovies
//
//  Created by Luiz Araujo on 08/03/23.
//

import SwiftUI

struct ContentView: View {
    let movies = Movie.sampleMovies
    /// Tracks the `ScrollView` content offsetX
    @State private var offsetX: CGFloat = 0
    @State private var maxOffsetX: CGFloat = -1

    var body: some View {
        GeometryReader { reader in
            let screenSize = reader.size

            ZStack {
                backgroundCarousel(screenSize: screenSize)

                movieCarousel(reader: reader)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    /// Background Parallax Effect
    func backgroundCarousel(screenSize: CGSize) -> some View {
//        let bgWidth = screenSize.width * CGFloat(movies.count)
        let bgWidth = UIScreen.main.bounds.width * CGFloat(movies.count)
        let scrollPercentage = offsetX / maxOffsetX
        let clampedPerccentage: CGFloat = 1 - max(0, min(scrollPercentage, 1))
        let posX: CGFloat = (bgWidth - screenSize.width) * clampedPerccentage

        return HStack(spacing: 0) {
            ForEach(movies.reversed()) { movie in
                Image(movie.imgString)
                    .resizable()
                    .scaledToFill()
                    .frame(width: screenSize.width)
                    .frame(maxHeight: .infinity)
                    .blur(radius: 1)
                    .scaleEffect(1.004)
                    .clipped()
                    .overlay(Color.black.opacity(0.45))
                    .ignoresSafeArea()
            }
        }
        .frame(width: bgWidth)
        .position(x: bgWidth / 2 - posX,
                  y: screenSize.height / 2)
    }

    func movieCarousel(reader: GeometryProxy) -> some View {
        let screenSize = reader.size
        let itemWidth = screenSize.width * 0.8
        let paddingX: CGFloat = (screenSize.width - itemWidth) / 2
        let spacing = CGFloat(10)

        return ScrollView(.horizontal) {
            HStack(spacing: 0) {

                GeometryReader { geo -> Color in
                    DispatchQueue.main.async {
                        offsetX = (geo.frame(in: .global).minX - paddingX) * -1
                        let scrollContentWidth = itemWidth * CGFloat(movies.count) + spacing * CGFloat(movies.count - 1)
                        let maxOffsetX = scrollContentWidth + 2 * paddingX - screenSize.width
                        if self.maxOffsetX == -1 {
                            self.maxOffsetX = maxOffsetX
                        }
                    }
                    return Color.clear
                }
                .frame(width: 0)

                HStack(spacing: spacing) {
                    ForEach(movies) { movie in
                        MovieItemView(screenSize: screenSize, width: itemWidth, movie: movie)
                    }
                }
            }
            .padding(.horizontal, paddingX)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

