//
//  ViewController.swift
//  ChineseCharacters
//
//  Created by mac on 13.10.2023.
//

import UIKit


enum Characters: String {
    case 你, 好 ,爱, 八, 杯, 子, 北, 京, 本,
         不, 客, 气, 菜, 茶, 吃, 出, 租, 车,
         打, 话, 大, 的, 点, 电, 脑, 视, 影,
         东, 西, 都, 读, 对, 起, 多, 少, 儿,
         饭, 馆, 飞, 机, 二, 分, 钟, 高, 兴,
         工, 作, 汉, 语, 个, 狗, 喝, 和, 很,
         后, 面, 回, 会, 火, 站, 几, 家, 叫,
         今, 天, 九, 开, 看, 块, 来, 老, 师,
         了, 冷, 里, 零, 六, 妈, 吗, 买, 猫,
         没, 关, 系, 米, 名, 字, 明,哪, 那,
         呢, 能, 无, 年, 女, 朋, 友, 漂, 亮,
         苹, 果, 七, 钱, 前, 请, 去, 热, 人,
         认, 识, 日, 三, 商, 店, 上, 衣, 谁,
         什, 么, 十, 是, 书, 水, 睡, 觉, 说,
         四, 岁, 他, 她, 太, 听, 同, 学, 我,
         们, 喂, 五, 喜, 欢, 下, 午, 雨, 先,
         生, 现, 在, 想, 办, 法, 小,  姐, 些,
         写, 谢, 星, 期, 习, 校, 服, 医, 院,
         椅, 一, 次, 有, 月, 再, 见, 怎, 样,
         这, 中, 国, 住, 桌, 昨,  坐, 做
    

}


let link = "https://api.ctext.org/getcharacter?char="

func getCharacterLink(character: Characters) -> String {
    let originalString = character.rawValue
    let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    guard let escapedString = escapedString else {
        return "EscapinkStringError"}
    let characterLink = link + escapedString
    return characterLink
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacter(character: Characters.脑)
    }
    
    
    func fetchCharacter(character: Characters) {
        let string = getCharacterLink(character: character)
        
        guard let url = URL(string: string) else {
            print("String problem")
            return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            print(data)
            do {
                let json = try JSONDecoder().decode(Character.self, from: data)
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


