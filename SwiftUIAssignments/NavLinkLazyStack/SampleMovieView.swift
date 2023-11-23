//
//  SampleMovieView.swift
//  SwiftUIAssignments
//
//  Created by Heedon on 2023/11/18.
//

import SwiftUI

struct SampleMovieView: View {
    
    let movie: Movie
    
    var body: some View {
        
        Text("Hello, World!")
        
    }
}

#Preview {
    SampleMovieView(movie: Movie(title: "안녕 헤이즐"))
}
