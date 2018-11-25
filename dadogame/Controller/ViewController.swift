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
    @IBOutlet weak var labelResult: UILabel!
    
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
        //print("lo que le paso a diceImage es: \(Int(nFaces)+1)")
        //me llevo las siguientes cuatro líneas al método animate del UIView para hacer la animación
        //imageViewDiceLeft.image = UIImage(named: diceImage[randomDiceIndexLeft])
        //imageViewDiceRight.image = UIImage(named: diceImage[randomDiceIndexRight])
        //labelResult.text = String(randomDiceIndexLeft + randomDiceIndexRight + 2)
        //ocultamos el resultado para mostrarlo cuando la animación haya terminado y no desvelarlo antes de tiempo, es decir, antes de que los dados terminen de moverse
        //labelResult.alpha = 0.0
        //labelResult.text = "?"
        
        //Animaciones
        UIView.animate(withDuration: 0.4, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            //aquí hacemos las animaciones, para ello accedemos a un componente que se llama transform para hacer una transformación afín y hay varios constructores: escalado, rotar, mover.. y hay un contructor que lo combina todo
            /*self.imageViewDiceLeft.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
             self.imageViewDiceLeft.transform = CGAffineTransform(translationX: 0, y: 100)
             self.imageViewDiceLeft.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)*/
            //comento lo anterior para hacer lo mismo de otra forma:
            //cualquier transformación afín se puede concatenar con otra transformación afín, eso hacemos a continuación
            
            self.imageViewDiceLeft.transform = CGAffineTransform(scaleX: 0.3, y: 0.3).concatenating(CGAffineTransform(rotationAngle: CGFloat.pi/2)).concatenating(CGAffineTransform(translationX: -70, y: 70))
            self.imageViewDiceRight.transform = CGAffineTransform(scaleX: 0.3, y: 0.3).concatenating(CGAffineTransform(rotationAngle: CGFloat.pi/2)).concatenating(CGAffineTransform(translationX: 70, y: 70))
            //hacemos desaparecer el dado después de la animación
            self.imageViewDiceLeft.alpha = 0.0
            self.imageViewDiceRight.alpha = 0.0
            //mostramos la ¿? en la etiqueta de resultado
            self.labelResult.text = "¿?"

        }) { (completed) in
            //lo primero una vez acabada la animación, devolvemos el estado a la identidad
            self.imageViewDiceLeft.transform = CGAffineTransform.identity
            self.imageViewDiceRight .transform = CGAffineTransform.identity
            //volvemos ha hacer aparecer el dado después de la animación
            self.imageViewDiceLeft.alpha = 1.0
            self.imageViewDiceRight.alpha = 1.0
            //volvermos ha hacer aparecer el resultado después de la animación
            //self.labelResult.alpha = 1.0
            //mostramos el resultado
            self.labelResult.text = String(self.randomDiceIndexLeft + self.randomDiceIndexRight + 2)

            //aquí hay que añadir self para acceder a la variable de la propia clase puesto que estos clouseres no están vinculados directamente al controlador, viven un poco donde les da la gana y hay que dejarlo claro porque sino el compilador se queja
            self.imageViewDiceLeft.image = UIImage(named: self.diceImage[self.randomDiceIndexLeft])
            self.imageViewDiceRight.image = UIImage(named: self.diceImage[self.randomDiceIndexRight])
            self.labelResult.text = String(self.randomDiceIndexLeft + self.randomDiceIndexRight + 2)
        }
    }
}

