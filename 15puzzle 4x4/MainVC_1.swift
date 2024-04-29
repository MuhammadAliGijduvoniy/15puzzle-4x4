//
//  MainVC.swift
//  15puzzle 4x4
//
//  Created by MuhammadAli on 19/12/23.
//

import UIKit

let windowWidth = UIScreen.main.bounds.width
let windowHeight = UIScreen.main.bounds.height

struct MIndex {
    var i = 0
    var j = 0
}

class MainVC: UIViewController {
    
    let spacingLeftRight: CGFloat = 20
    let spacingTop: CGFloat = 50
    let spacing : CGFloat = 10
    
    
    private var emptyIndex = MIndex(i: 3, j: 3)
    
    private var numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    
    private var topLabel = UILabel()
    
    private let buttonContainer = UIView()
    
    private var buttons = [[UIButton(),UIButton(),UIButton(),UIButton()],
                           [UIButton(),UIButton(),UIButton(),UIButton()],
                           [UIButton(),UIButton(),UIButton(),UIButton()],
                           [UIButton(),UIButton(),UIButton(),UIButton()]]
    
    private var matrix = [[0,0,0,0],
                          [0,0,0,0],
                          [0,0,0,0],
                          [0,0,0,0]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
        newGame()
    }
    
    
    
    func setupUI() {
        topLabel.frame = CGRect(
            x: spacingLeftRight,
            y: spacingTop * 2,
            width: windowWidth - spacingLeftRight * 2,
            height: spacingTop)
        topLabel.text = "Step: 0"
        topLabel.font = .boldSystemFont(ofSize:  32)
        topLabel.textColor = .black
        topLabel.textAlignment = .center
        topLabel.layer.cornerRadius = 12
        topLabel.layer.borderColor = UIColor.black.cgColor
        topLabel.layer.borderWidth = 2
        self.view.addSubview(topLabel)
        
        buttonContainer.frame = CGRect(
            x: spacingLeftRight,
            y: topLabel.frame.maxY + 80,
            width: windowWidth - spacingLeftRight * 2,
            height: windowWidth - spacingLeftRight * 2)
        buttonContainer.layer.cornerRadius = 12
        buttonContainer.layer.borderColor = UIColor.black.cgColor
        buttonContainer.layer.borderWidth = 2
        self.view.addSubview(buttonContainer)
        
        let buttonWidth: CGFloat = (windowWidth - spacingLeftRight * 2 - spacing * 5) / 4
       
        
        for i in 0...3 {
            for j in 0...3 {
                self.buttons[i][j] = self.createButton(
                    frame: CGRect(
                        x: spacing + CGFloat(i) * (buttonWidth + spacing),
                        y: spacing + CGFloat(j) * (buttonWidth + spacing),
                        width: buttonWidth,
                        height: buttonWidth),
                    tag: (4 * i + j))
                self.buttonContainer.addSubview(buttons[i][j])
            }
        }
       
        
    }
    
    func reloadData() {
        for i in 0...3 {
            for j in 0...3 {
                if matrix[i][j] == 0 {
                    self.buttons[i][j].setTitle("", for: .normal)
                } else {
                    self.buttons[i][j].setTitle(String(matrix[i][j]), for: .normal)
                }
            }
        }
    }
    
    func newGame() {
        self.numbers.shuffle()
        self.initData()
        self.matrix[3][3] = 0
    }
    
    func initData() {
        for i in 0...3 {
            for j in 0...3 {
                if (4 * i + j) != 15 {
                    self.buttons[i][j].setTitle(String(self.numbers[4 * i + j]), for: .normal)
                    matrix[i][j] = self.numbers[4 * i + j]
                }
            }
        }
    }
    
   
    
    func createButton(frame: CGRect, tag: Int) -> UIButton  {
        let btn = UIButton()
        btn.frame = frame
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.titleLabel?.font = .boldSystemFont(ofSize: 32)
        btn.tag = tag
        btn.addTarget(self, action: #selector(onButtonClikck), for: .touchUpInside)
        
        return btn
    }
    
    func getIndex(_ tag: Int) -> MIndex {
        let i = tag / 4
        let j = tag % 4
        return MIndex(i: i, j: j)
    }
    
    func moveTo(_ index: MIndex) {
        self.matrix[emptyIndex.i][emptyIndex.j] = self.matrix[index.i][index.j]
        self.matrix[index.i][index.j] = 0
        self.emptyIndex = index
        self.reloadData()
    }

    @objc func onButtonClikck(_ sender: UIButton) {
        let index = self.getIndex(sender.tag)
        
        if ((index.i + 1) == self.emptyIndex.i) && index.j == self.emptyIndex.j {
            self.moveTo(index)
        } else if ((index.i - 1) == self.emptyIndex.i) && index.j == self.emptyIndex.j {
            self.moveTo(index)
        } else if ((index.j - 1) == self.emptyIndex.j) && index.i == self.emptyIndex.i {
            self.moveTo(index)
        } else if ((index.j + 1) == self.emptyIndex.j) && index.i == self.emptyIndex.i {
            self.moveTo(index)
        }
    }

}
