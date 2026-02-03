//
//  ItemDetailView.swift
//  iDine
//
//  Created by automated edit on 1/23/26.
//

import SwiftUI

struct ItemDetailView: View {
    let item: MenuItem

    // state for pinch-to-zoom and double-tap
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // make the image zoomable
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .accessibilityIdentifier("fullImage_\(item.id)")
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture(count: 2) {
                        // double tap to toggle between 1x and 2x
                        withAnimation(.spring()) {
                            if scale > 1.0 {
                                scale = 1.0
                                lastScale = 1.0
                            } else {
                                scale = 2.0
                                lastScale = 2.0
                            }
                        }
                    }
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                // combine the new magnification with the previous one
                                let newScale = lastScale * value
                                // clamp to reasonable bounds
                                scale = min(max(newScale, 1.0), 5.0)
                            }
                            .onEnded { _ in
                                // store the last scale for subsequent gestures
                                lastScale = min(max(scale, 1.0), 5.0)
                            }
                    )

                Text(item.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text("$\(item.price)")
                    .font(.title2)
                    .foregroundColor(.secondary)

                if !item.description.isEmpty {
                    Text(item.description)
                        .font(.body)
                }

                if !item.photoCredit.isEmpty {
                    Text("Photo: \(item.photoCredit)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // reset scale when view appears
            scale = 1.0
            lastScale = 1.0
        }
    }
}

#Preview {
    ItemDetailView(item: MenuItem.example)
}
