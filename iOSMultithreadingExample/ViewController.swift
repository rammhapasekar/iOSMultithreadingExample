//
//  ViewController.swift
//  iOSMultithreadingExample
//
//  Created by Ram Mhapasekar on 26/03/17.
//  Copyright © 2017 rammhapasekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var inactivateQueue: DispatchQueue!

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:
    //MARK: sync thread implementation
    
    @IBAction func syncBtnClicked(_ sender: Any) {
        
        simpleSyncQueues()
    }
    
    //MARK:
    //MARK: async thread implementation
    
    @IBAction func asyncBtnClicked(_ sender: Any) {
        
        simpleAsyncQueues()
    }
    
    //MARK:
    //MARK: queueWithQoSB thread implementation
    
    @IBAction func queueWithQoSBtnClicked(_ sender: Any) {
        
        queuesWithQoS()
    }
    
    //MARK:
    //MARK: serialQueues thread implementation
    
    @IBAction func serialQueuesBtnClicked(_ sender: Any) {
        
        serialQueue()
    }
    
    //MARK:
    //MARK: concurrentQueues thread implementation
    
    @IBAction func concurrentQueuesBtnClicked(_ sender: Any) {
        
        concurrentQueue()
    }
    
    //MARK:
    //MARK: initallyInactiveQueue thread implementation
    
    @IBAction func initallyInactiveQueueBtnClicked(_ sender: Any) {
        
        initallyInactiveConcurrentQueue()
        
        if let queue = inactivateQueue{
            queue.activate()
        }
    }
    
    
    //MARK:
    //MARK: queue with delay thread implementation
    
    @IBAction func queueWithDelay(_ sender: Any) {
        
        queueWithDelay()
    }
   
    //MARK:
    //MArk: Global queue implementation
    @IBAction func globalQueue(_ sender: Any) {
        
        gloabalQueue()
    }
    
    
    //MARK:
    //MARK: Implementation of DispathQueues
    
    func simpleSyncQueues(){
        
    /*
     READ ME to know Sycnchronous thread ::
     
     The program execution will stop though in the queue’s block; It won’t continue to the main thread’s loop and it won’t display the numbers from 100 to 109 until the queue’s task has finished. And that happens because we make a synchronous execution.
     
     */
     
        let queue = DispatchQueue(label: "myqueues")
        
        //The following block will run on background queue ie. queue
        queue.sync {
            for i in 1...10{
                
                print("Ⓜ️", i)
            }
        }
        
        
        //The following block will run on main thread
        
        for i in 101...110{
            
            print("💖", i)
        }
    }
    
    
    func simpleAsyncQueues(){
        
    /*
     READ ME for Asynchronous thread ::
     When we run this block we can clearly see that our main queue is free to “work” while we have another task running on the background, and this didn’t happen on the synchronous execution of the queue.
     */
        
        let queue1 = DispatchQueue(label: "myqueues1")
        
        //The following queue will run of background thread asynchronously
        queue1.async {
            
            for i in 1...10{
                
                print("Ⓜ️", i)
            }
        }
        
        //The following code will run on the main thread
        for i in 101...110{
            
            print("💖", i)
        }
    }
    
    
    //MARK:
    //MARK: Quality Of Services (QoS) and Priorities

    /*
     It’s quite often necessary to tell the system which tasks of your app are more important than others and which need priority in execution when working with the GCD and dispatch queues. Of course, tasks running on the main thread have always the highest priority, as the main queue also deals with the UI and keeps the app responsive. In any case, by providing that information to the system, iOS prioritises the queues properly and gives the needed resources (like execution time on CPU) according to what you’ll specify. Needless to say that all the tasks will eventually finish. However, the difference lies to which tasks will finish sooner, and which later.
     
     That information regarding the importance and priority of the tasks is called in GCD Quality of Service (QoS). In truth, QoS is an enum with specific cases, and by providing the proper QoS value upon the queue initialisation you specify the desired priority. If no QoS is defined, then a default priority is given by to the queue. The following list summarises the available QoS cases, also called QoS classes. The first class means the highest priority, the last one the lowest priority:
     
     * userInteractive
     * userInitiated
     * default
     * utility
     * background
     * unspecified
    */
    
    
    func queuesWithQoS(){
        
        //Club the any two queses and check the behaviour in each senario to understand the how qos and priorities work here
        
        let queue1 = DispatchQueue(label: "queue1", qos: DispatchQoS.userInteractive)
        let queue2 = DispatchQueue(label: "queue2", qos: DispatchQoS.userInitiated)
//        let queue3 = DispatchQueue(label: "queue3", qos: DispatchQoS.default)
//        let queue4 = DispatchQueue(label: "queue4", qos: DispatchQoS.utility)
//        let queue5 = DispatchQueue(label: "queue5", qos: DispatchQoS.background)
//        let queue6 = DispatchQueue(label: "queue6", qos: DispatchQoS.unspecified)
        
        queue1.async {
            for i in 1...10{
                print("Ⓜ️", i)
            }
        }
        
        queue2.async {
            for i in 101...110{
                print("💖", i)
            }
        }
    }
    
    
    func serialQueue(){
        
    /*
    READ ME serial queues::
    When ever we assign more than one task to the queue then thoes task will perform one after another and not together
    */
        let serialQueue = DispatchQueue(label: "serialQueue", qos: .utility)
        
        serialQueue.async {
            
            for i in 1...10{
                print("Ⓜ️", i)
            }
        }
        
        serialQueue.async {
            
            for i in 101...110{
                print("💖", i)
            }
        }
        
        serialQueue.async {
            
            for i in 1001...1010{
                print("😝", i)
            }
        }
    }
    
    
    func  concurrentQueue(){
        
    /*
         When we add attributes as concurrent then the dispatch queue will act as concurrent queue for us, and all the tasks of the specific queue will be executed simultaneously and the parallel execution of the task will be respected within the queue
    */
        let concurrentQueue = DispatchQueue(label: "concurrentQueue", qos: .utility, attributes: [.concurrent])
        
        concurrentQueue.async {
            
            for i in 1...10{
                print("Ⓜ️", i)
            }
        }
        
        concurrentQueue.async {
            
            for i in 101...110{
                print("💖", i)
            }
        }
        
        concurrentQueue.async {
            
            for i in 1001...1010{
                print("😝", i)
            }
        }
    }
    
    
    func  initallyInactiveConcurrentQueue(){
        
        let inactiveConcurrentQueue = DispatchQueue(label: "concurrentQueue", qos: .utility, attributes: [.concurrent, .initiallyInactive])
        
        inactivateQueue = inactiveConcurrentQueue
        
        inactiveConcurrentQueue.async {
            
            for i in 1...10{
                print("Ⓜ️", i)
            }
        }
        
        inactiveConcurrentQueue.async {
            
            for i in 101...110{
                print("💖", i)
            }
        }
        
        inactiveConcurrentQueue.async {
            
            for i in 1001...1010{
                print("😝", i)
            }
        }
    }
    
    
    func  queueWithDelay(){
        
        let queueWithDelay = DispatchQueue(label: "queueWithDelay", qos: .userInitiated, attributes: .concurrent)
        
        let delayQueue: DispatchTimeInterval = .seconds(4)

        queueWithDelay.asyncAfter(deadline: .now() +  delayQueue){
            
            queueWithDelay.async {
                
                for i in 1...10{
                    print("Ⓜ️", i)
                }
            }
            
            queueWithDelay.async {
                
                for i in 101...110{
                    print("💖", i)
                }
            }
            
            queueWithDelay.async {
                
                for i in 1001...1010{
                    print("😝", i)
                }
            }
        }
    }
    
    func gloabalQueue(){
        imageView.image = UIImage(named: "loading")
        
        DispatchQueue.global(qos: .userInitiated).async{
            
            let imageURL: URL = URL(string: "https://c1.staticflickr.com/5/4088/5093723696_85887b688c_b.jpg")!
            
            (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in
                
                if let data = imageData {
                    print("Did download image data")
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }).resume()
        }
    }
}
