//
//  ConditionsViewController.swift
//  Rebrus
//
//

import UIKit

struct Condition {
    let conditionTitle: String
    let conditionText: String?
}
class ConditionsViewController: UIViewController {
    
    private let conditions = [
        Condition(conditionTitle: "Правила и условия услуг Rebrus".localized(from: .main), conditionText: nil),
        Condition(conditionTitle: "1. Введение".localized(from: .main), conditionText: "Добро пожаловать на Rebrus, телемедицинскую платформу, предназначенную для облегчения удаленных медицинских консультаций. Получая доступ к Rebrus и используя его, вы соглашаетесь соблюдать настоящие Правила и условия.".localized(from: .main)),
        Condition(conditionTitle: "2. Права пользователя".localized(from: .main), conditionText: "Услуги Rebrus доступны лицам старше 18 лет. Пользователи в юрисдикциях, где телемедицина ограничена, могут не иметь права пользоваться Rebrus.".localized(from: .main)),
        Condition(conditionTitle: "3. Политика конфиденциальности".localized(from: .main), conditionText: "Ваша конфиденциальность является приоритетом в Rebrus. Мы собираем личные и медицинские данные, необходимые для оказания медицинских услуг, которые защищены и не передаются третьим лицам без вашего явного согласия, за исключением случаев, предусмотренных законом. Вы можете получить доступ, изменить или запросить удаление ваших данных.".localized(from: .main)),
        Condition(conditionTitle: "4. Обязанности пользователя".localized(from: .main), conditionText: "Вы должны предоставить точную и полную медицинскую информацию. Любое неправомерное использование Rebrus, например мошеннические действия, строго запрещено. Вы несете ответственность за сохранение конфиденциальности ваших учетных данных для входа.".localized(from: .main)),
        Condition(conditionTitle: "5. Телемедицинские услуги".localized(from: .main), conditionText: "Rebrus предлагает онлайн-консультации и услуги по выписыванию рецептов. Однако телемедицина имеет ограничения и не подходит для экстренных случаев. В экстренных случаях немедленно обратитесь в местные службы экстренной помощи.".localized(from: .main)),
        Condition(conditionTitle: "6. Сборы и оплата".localized(from: .main), conditionText: "Стоимость услуг указана в Rebrus и может быть изменена. Способы оплаты и информация о страховом покрытии доступны в приложении.".localized(from: .main)),
        Condition(conditionTitle: "7. Отказ от ответственности и ограничения ответственности".localized(from: .main), conditionText: "Rebrus не несет ответственности за перебои в обслуживании или неточности в медицинских рекомендациях. Результаты лечения, основанного на наших консультациях, не гарантируются.".localized(from: .main)),
        Condition(conditionTitle: "8. Интеллектуальная собственность".localized(from: .main), conditionText: "Контент и услуги, предоставляемые Rebrus, защищены законами об интеллектуальной собственности. Несанкционированное использование содержимого приложения запрещено.".localized(from: .main)),
        Condition(conditionTitle: "9. Прекращение использования".localized(from: .main), conditionText: "Rebrus оставляет за собой право прекратить ваш доступ за нарушение настоящих условий. Вы можете деактивировать свою учетную запись через настройки приложения.".localized(from: .main)),
        Condition(conditionTitle: "11. Поправки к Условиям".localized(from: .main), conditionText: "Rebrus может обновлять настоящие условия. Продолжение использования после внесения изменений означает принятие новых условий.".localized(from: .main)),
        Condition(conditionTitle: "10. Применимое законодательство и разрешение споров".localized(from: .main), conditionText: "Настоящие условия регулируются законами Республики Казахстан. Споры будут разрешаться в арбитражном порядке.".localized(from: .main)),
        Condition(conditionTitle: "12. Контактная информация".localized(from: .main), conditionText: "Для получения поддержки или вопросов обращайтесь к нам по адресу rebrus@rebrus.kz.".localized(from: .main))]
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Изменено: 01 / 01 / 2024".localized(from: .main)
        label.textColor = .white
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        return label
    }()
    
    private let textView: UITextView = {
        let view = UITextView()
        view.font = UIFont(name: "Montserrat-Regular", size: 14)
        view.textColor = ColorManager.blueTextColor
        view.isEditable = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Условие и политика".localized(from: .main)
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        for condition in conditions {
            setTextView(with: condition)
        }
        let dateBlock = setDateBlock()
        
        view.addSubview(dateBlock)
        dateBlock.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalToSuperview().inset(120)
            make.height.equalTo(40)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalTo(dateBlock.snp.bottom).offset(26)
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setDateBlock() -> UIView {
        let block = UIView()
        block.layer.cornerRadius = 12
        block.backgroundColor = ColorManager.blue
        
        block.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        return block
    }
    
    private func setTextView(with condition: Condition) {
        if let existingText = textView.text, !existingText.isEmpty {
            textView.text += "\n\n\(condition.conditionTitle)"
            textView.text += "\n\(condition.conditionText ?? "")"
        } else {
            textView.text = condition.conditionTitle
        }
    }
}
