//
//  ViewController.swift
//  dadogame
//
//  Created by superw on 22/11/2018.
//  Copyright © 2018 superw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageViewDiceLeft: UIImageView!
    @IBOutlet weak var imageViewDiceRight: UIImageView!
    
    var randomDiceIndexLeft : Int = 0
    var randomDiceIndexRight : Int = 0

    // esta no hace falta que sea una variable puesto que siempre tendremos estos nombres en el array de string y tampoco sería necesario indicar que es de String porque Switf lo infiere al inicializarlo con cadenas (después, nos hemos llevado la inicialización al constructor Init que hemos definido)
    // en principio nuestro dado tiene 6 caras, pero el código quedará preparado para que puedan haber dados de más caras
    //let diceImage : [String] = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    let diceImage : [String]
    
    // como esta constante global queremos inicializarla con el valor de una propiedad de otra variable o constante global (Que es diceImage) puede ser que el compilador aún no la tenga disponible a la hora de crearla, es decir, estamos utilizando un objeto que es global y no podemos asegurar que estará creado antes de llegar a esta sentencia. Por eso comentamos la siguiente linea y la inicializamos como explico más abajo
    //let nFaces : UInt32 = diceImage.count
    
    // declaramos nFaces como un entero sin signo de 32 bits (que es lo que va a necesitar arc4random luego) de forma global
    let nFaces : UInt32
    // y entonces ahora hay que inicializarla (ahora mismo el compilador se queja porque la clase viewController no tiene inicializador
    // utilizamos el inicializador por defecto para inicializar variable que no hayan sido inicializadas previamente
    // este inicializador tiene un requisito un poco especial y es que hay que llamar a super.ini() en la útlima línea, que lo último que haga sea llamar a inicializador de su superclase antes de salir. Además utlizamos el inicializador o constructor que tiene un parámetro de tipo NSCoder y devolvermos el mismo que recibimos
    // ya que tenemos un incializador metemos también la asignación inicial de diceImage (siempre antes de nFaces puesto que utilizamos y necesitamos su propiedad.count)
    required init?(coder aDecoder: NSCoder) {
        diceImage = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
        nFaces = UInt32(diceImage.count)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view, typically from a nib.
    }
    
    // método que se llama al pulsar el botón
    @IBAction func rollPressed(_ sender: UIButton) {
        //llamamos a nuestra funcion que gerena los dos indices aleatorios y los deja en las variables randomDiceLeft y Right
        generateRandomDices()
    }
    
    // esta función gerena dados aleatorios fuera del método que se va a llamar cuando se pulse el botón
    func generateRandomDices (){
        // la funcion arc4random devuelve un entero sin signo de 32 UInt32 y no la podemos asignar a nuestra variable de tipo entera (Int) sin hacer un casting
        // usamos esta constante para recoger el número de caras o elementos de la colección de tipo array diceImage, evitando así hardcodear pasándole un número entero a piñón (como poner un número 6). De esta forma aunque se modificara el número de elementos del array la aplicación no petaría.
        // esta constante debería ser global, pero pasarla a globar implica tener que llamar a un inicializador puesto que utiliza una propiedad (count) de otro objeto global (diceImage) que en el momento de la creación no estará disponible, solución más arriba
        //let nFaces : UInt32 = UInt32(diceImage.count)
        // estas dos variables se les podría asignar el valor que necesitamos de la siguiente forma sin necesidad de tener la contante globar nFace, le pasamos como parámetro directamente la propiedad count de diceImage haciendo el casting en la misma llamada
        //randomDiceIndexLeft = Int(arc4random_uniform(UInt32(diceImage.count)))
        //randomDiceIndexRight = Int(arc4random_uniform(UInt32(diceImage.count)))
        randomDiceIndexLeft = Int(arc4random_uniform(UInt32(nFaces)))
        randomDiceIndexRight = Int(arc4random_uniform(UInt32(nFaces)))
        print ("Indice izquierdo: \(randomDiceIndexLeft) , Indice derecho: \(randomDiceIndexRight)")
    }


}

