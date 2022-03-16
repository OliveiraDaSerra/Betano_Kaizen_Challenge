//
//  GameInfoCollectionViewCell.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import UIKit
import SnapKit

class GameInfoCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        return stackView
    }()

    private lazy var timerContainerView: UIView = {
        let tcv = UIView()
        tcv.backgroundColor = .clear
        return tcv
    }()

    private lazy var timerLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = Definitions.UIComponents.title.textColor
        lbl.textAlignment = Definitions.UIComponents.title.alignment ?? .center
        lbl.font = Definitions.UIComponents.title.font
        return lbl
    }()

    private lazy var favouriteButton: UIButton = {
        let fb = UIButton()
        fb.addTarget(self, action: #selector(onFavouriteButtonPressed(_:)), for: .touchUpInside)
        return fb
    }()

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        return stackView
    }()

    private lazy var homeTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = Definitions.UIComponents.title.textColor
        lbl.textAlignment = Definitions.UIComponents.title.alignment ?? .center
        lbl.font = Definitions.UIComponents.title.font
        return lbl
    }()

    private lazy var awayTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = Definitions.UIComponents.title.textColor
        lbl.textAlignment = Definitions.UIComponents.title.alignment ?? .center
        lbl.font = Definitions.UIComponents.title.font
        return lbl
    }()

    private var field: FieldBase?

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        commonInit()
    }

    private func commonInit() {
        setupUI()
        configureNotification()
    }

    func configureNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTimeInformation),
                                               name: .updateTimer,
                                               object: nil)
    }

    private func removeNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: .updateTimer,
                                                  object: nil)
    }

    private func setupUI() {

        // > Content View Config
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5.0
        contentView.layer.borderWidth = 0.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        // > Properties Config
        if timerLabel.superview == nil { timerContainerView.addSubview(timerLabel) }
        if timerContainerView.superview == nil { stackView.addArrangedSubview(timerContainerView) }
        if favouriteButton.superview == nil { stackView.addArrangedSubview(favouriteButton) }
        if homeTitleLabel.superview == nil { titleStackView.addArrangedSubview(homeTitleLabel) }
        if awayTitleLabel.superview == nil { titleStackView.addArrangedSubview(awayTitleLabel) }
        if titleStackView.superview == nil { stackView.addArrangedSubview(titleStackView) }
        if stackView.superview == nil { contentView.addSubview(stackView) }

        stackView.snp.removeConstraints()
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        timerLabel.snp.removeConstraints()
        timerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4.0)
            make.height.equalTo(22.0)
        }

        favouriteButton.snp.removeConstraints()
        favouriteButton.snp.makeConstraints { make in
            make.height.equalTo(44.0)
        }
    }

    func update(with field: FieldBase?) {
        self.field = field
        updateTimeInformation()
        updateFavouriteButton()
        updateTeamsInformation()
    }

    private func createTimeInformation() -> String {
        guard let startTime = field?.startTime else { return "<Invalid>" }

        let userCalendar = Calendar.current
        let calendarComponents: Set<Calendar.Component> = [.hour, .minute, .month, .year, .day, .second]
        // > Current Date And Event Date Components
        let currentDateComponents = userCalendar.dateComponents(calendarComponents, from: Date())
        let eventDateComponents = userCalendar.dateComponents(calendarComponents,
                                                              from: Date(timeIntervalSince1970: startTime))

        let currentDate = userCalendar.date(from: currentDateComponents)!
        let eventDate = userCalendar.date(from: eventDateComponents)!

        // Time Left Components
        let timeLeftComponents = userCalendar.dateComponents([.day, .hour, .minute, .second],
                                                             from: currentDate,
                                                             to: eventDate)

        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.includesApproximationPhrase = false
        formatter.includesTimeRemainingPhrase = false
        formatter.allowedUnits = [.day, .hour, .minute, .second]

        return formatter.string(from: timeLeftComponents) ?? "<Invalid>"
    }

    @objc private func updateTimeInformation() {
        guard let field = field, let startTime = field.startTime else { return }
        if Date(timeIntervalSince1970: startTime) > Date() {
            timerLabel.text = createTimeInformation()
        } else {
            timerLabel.text = "Started!"
            removeNotification()
        }
    }

    private func updateFavouriteButton() {
        guard let field = field else { return }
        favouriteButton.setImage(UIImage(systemName: "star\(field.favourite ? ".fill" : "")"), for: .normal)
    }

    private func updateTeamsInformation() {
        guard let field = field else { return }
        let teamsNames = (field.title ?? "").components(separatedBy: "-")
        if teamsNames.count > 1 {
            homeTitleLabel.text = (teamsNames.first ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            awayTitleLabel.text = (teamsNames.last ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    @objc private func onFavouriteButtonPressed(_ button: UIButton) {
        guard let handler = field?.handler else { return }
        handler(field?.key)
    }
}

