//
//  ViewController.swift
//  AccessTokenMechanism
//
//  Created by Mickey Lee on 23/02/2022.
//

import UIKit
import Combine

final class ViewController: UIViewController {

    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let repository = FeedbackRepository()
        repository.sendFeedback()
            .sink { complete in
                if case let .failure(error) = complete {
                    print(error)
                }
            } receiveValue: { channel in
                print(channel)
            }
            .store(in: &cancellables)
    }
}

