//
//  main.swift
//  OOP
//  Обучение Объектно-Ориентированному программированию
//
//  Created by apple on 01.10.2023.
//

import Foundation

//MARK: Тип данных Функция

func plusFunction(_ first : Int, _ second : Int) -> Int{
    return first + second
}
func minusFormula(_ first: Int, _ second : Int) -> Int {
    return first - second
}
func multiplyFormula(_ first: Int, _ second : Int) -> Int {
    return first * second
}
func delenieFormula(_ first: Int, _ second: Int) -> Int {
    return first / second
}
func math(_ formula : (Int, Int) -> Int, _ first : Int, _ second : Int) {
    print("Result \(formula(first,second))")
}
math(plusFunction, 9, 10)
math(minusFormula, 102, 2)
math(multiplyFormula, 92, 10)
math(delenieFormula, 10, 1)
//Функции которые принимает в качестве параметров другие функции, это функции высшего порядка


func returnFunc(bool : Bool) -> (Int,Int) -> Int {
    if bool {
        return plusFunction
    } else {
        return minusFormula
    }
}

let getFunc = returnFunc(bool: true)
print(getFunc(103,100))
print(returnFunc(bool: false)(100,48))

// Возвращаем пустоту
func returnVoid () -> Void {
    
}

// Встроенные функции
func someFunction(){
    func nestedFunc(){
        print("nestedFunc")
    }
    func anotherNestedFunc(){
        print("anotherNestedFunc")
    }
    
    nestedFunc()
    anotherNestedFunc()
}

someFunction()

// MARK: Кложуры/замыкания
// Тело функции не так сильно отличается от тела кложура
// Ключевое слово "in" необходимо для разделения области с параметрами кложура и областью с кодом


var addVar: (Int, Int) -> Bool = { a, b in
    if a > b {
        return true
    } else { return false }
}
print(addVar(10,11))

/*
 Отличие кложуров от функции
 Кложур не имеет имени, он напрямую присваивается в перменную
 Затем используется без имени
 Кложуры принимают одну из 3 форм :
    1) Глобальные функции, которые с именем и которые не захватывают значение
    2) Внутренняя функция, имеет имя также может захватывать значение
    3) Кложур без имени, который выполняет какую-то важную задачу
 Обычно под клажуром подразумивают именно 3 форму. 2 остальные формы используются редко
 Кложуры необхожимо для упрощения синтаксиса программы
 Для того, чтобы каждый раз не писать
 Клажур можно сокращать
 Запись выше мы можем сократить до следущего формата
*/

var closureAdd: (Int,Int) -> Int = { $0 + $1 }

/*
 Можно не записывать ключевое слово, return, так как swift понимает, что возращается одно значение. Понимает из типа возращаемого значение
 При такой записи , язык swift понимает что в данном кложуре есть 2 параметра. Понимает из типа аргумента. $0 для того, чтобы обратиться к первому параметру, и $1 для того, чтобы обратиться ко второму параметру.
*/

func myfanc(a : Int, b : Int, mathFunc : (Int,Int) -> Int){
    let result = mathFunc(a, b)
    print(result)
}

myfanc(a: 10, b: 20, mathFunc: { $0 - $1 })

/*
 Так можем ипользовать кложуры в таком формате, вместе создания новой функции и прописании длинного кода.
 Мы передали кложур, в аргумент функции myfanc.
 Что у нас произошло в данном коде.
 Язык swift, понял, что мы передали аргумент, в данном случаи кложур, который сам принимает 2 аргумента и возвращает их значение
 */
// Если последний параметр функции кложур, то скобку можно передвинуть и записать код в следующем виде
myfanc(a: 10, b: 11) { $0 * $1 }
myfanc(a: 12, b: 12) { $0 / $1 }
// Эта запись ничем не отличается от другого варианта, кроме удобства чтения и лучшего понимания написанного
// Такая запись называется tail notashing (хвостовое описание)

// АвтоКложур
func autoClosures(isOk: Bool, closure: @autoclosure () -> Void){
    if isOk {
        closure()
    } else { print("Sorry") }
}
// Ключевое слово @autoclosure позволяет избежать фигурных скобок {}
autoClosures(isOk: true, closure: print("Hello"))
// Есть момент, что если мы будем возращать значение и выполним данный код вот так :
func autoClosuresExample(isOk: Bool, closure: @autoclosure () -> Int){
    if isOk {
        print(closure())
    } else { print("Sorry") }
}
// То при его вызове, можно запутаться с тем, что это у нас не переменная которая принимает значение. А это у нас кложур объявлен в аргменте
autoClosuresExample(isOk: true, closure: 4) // С этим надо быть аккуратнее. Эпл не рекомендует это делать


// MARK: Захват значения

var integer: Int = 5
var someClosure = { integer += 1 } // Кложур дописывает значение в переменную
someClosure() // integer + 1
integer += 1
someClosure() // integer + 1
print(integer)

// У каждого кложура, есть список того, что он захватывает снаружи.
// Мы можем этот список указать явно. Это делается при поможи квадратных скобок, после объявления кложура. И в этих квадратных скобках указваются перменные или данные, которые этот кложур захватывает. При захвате значение, у нас изменяется поведение кложура. Мы не можем изменить значение захваченной переменной. Также мы можем изменить внутреннее название, через присвоение нового имени вначале.
var newClosure = { [of = integer] in print(of) }
newClosure() // Скопировал и вывел на экран 8
integer += 1 // Добавили к оригинальной перменной +1
newClosure() // Вызвали копию
print("Значение нашей переменной \(integer)")
// Кложур, в момент захвата значения, не использует оригинальную переменную. Он копирует себе значения переменной
// При объявлении чего-то, в capture list в клажуре. Это значение будет скопированно!!!!
