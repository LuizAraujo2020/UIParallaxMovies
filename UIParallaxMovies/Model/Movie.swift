//
//  Movie.swift
//  UIParallaxMovies
//
//  Created by Luiz Araujo on 08/03/23.
//

struct Movie: Identifiable {
    var id: String { title }
    let title: String
    let rating: Int
    let imgString: String

    static let sampleMovies = [
        Movie(title: "How to Train your Dragon", rating: 5, imgString: "image-1"),
        Movie(title: "Star Wars", rating: 4, imgString: "image-2"),
        Movie(title: "Arrival", rating: 3, imgString: "image-3"),
        Movie(title: "Who am I", rating: 2, imgString: "image-4"),
        Movie(title: "Interestellar", rating: 5, imgString: "image-5"),

    ]
}
