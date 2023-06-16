//
//  FurkanYUKCU_FINALTests.swift
//  FurkanYUKCU_FINALTests
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import XCTest
@testable import FurkanYUKCU_FINAL
import FurkanYUKCU_FINAL
import iTunesAPI

class MusicCellPresenterTests: XCTestCase {
    
    var presenter: MusicCellPresenter!
    var mockView: MockMusicCellView!
    var mockInteractor: MockMusicCellInteractor!
    let mockMusic = Music(artistName: "Test Track", collectionName: "Test Artist", trackName: "Test Collection", previewURL: "test_url", artworkUrl100: "test_artwork_url", collectionPrice: 25.32 , trackPrice: 15.75 , primaryGenreName: "Test Primary Genre Name")
    
    override func setUpWithError() throws {
        mockView = MockMusicCellView()
        mockInteractor = MockMusicCellInteractor()
        presenter = MusicCellPresenter(view: mockView, interactor: mockInteractor, music: mockMusic)
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        mockView = nil
        mockInteractor = nil
    }
    
  
    
    func testOnImageResult() {
        let imageData = Data()
        presenter.load()
        presenter.onImageResult(imageData)
        
        XCTAssertEqual(mockView.musicImageData, imageData)
    }

}

class MockMusicCellView: MusicCellProtocol {
    
    var trackName: String?
    var artistName: String?
    var collectionName: String?
    var musicImageData: Data?
    
    func trackName(_ text: String) {
        trackName = text
    }
    
    func artistName(_ text: String) {
        artistName = text
    }
    
    func collectionName(_ text: String) {
        collectionName = text
    }
    
    func musicImg(_ data: Data) {
        musicImageData = data
    }
}

class MockMusicCellInteractor: MusicCellInteractorProtocol {
    
    var fetchImageCalled = false
    var fetchImageURL: String?
    
    func fetchImage(_ imageURL: String) {
        fetchImageCalled = true
        fetchImageURL = imageURL
    }
}
import XCTest
@testable import FurkanYUKCU_FINAL

class DetailViewControllerTests: XCTestCase {

    var viewController: DetailViewController!
    var mockPresenter: MockDetailPresenter!

    override func setUpWithError() throws {
        viewController = DetailViewController()
        mockPresenter = MockDetailPresenter()
        viewController.presenter = mockPresenter
    }

    override func tearDownWithError() throws {
        viewController = nil
        mockPresenter = nil
    }

    func testViewDidLoad() {
        viewController.viewDidLoad()

        XCTAssertTrue(mockPresenter.viewDidLoadCalled)
    }

    func testPlayButtonTapped() {
        viewController.playButton(UIButton())

        XCTAssertTrue(mockPresenter.playButtonTappedCalled)
    }
}

class MockDetailPresenter: DetailPresenterProtocol {

    var viewDidLoadCalled = false
    var playButtonTappedCalled = false

    func viewDidLoad() {
        viewDidLoadCalled = true
    }

    func playButtonTapped() {
        playButtonTappedCalled = true
    }
}
