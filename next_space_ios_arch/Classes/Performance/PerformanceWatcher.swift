//
//  PerformanceWatcher.swift
//  next_space_ios_arch
//  cpu 和内存监控卡点
//  Created by XXF on 2023/2/23.
//
import Foundation
final public class PerformanceWatcher: NSObject{
    fileprivate let performanceСalculator : PerformanceCalculator;
    fileprivate let cpuMax : Double;//百分比 0-100
    fileprivate let memoryMax : Double;//单位M
    
    @objc public convenience init(cpuMax: Double = 200,  memoryMax: Double = 200){
        self.init(cpuMax: cpuMax,memoryMax: memoryMax,flag: 1)
    }
    
    @objc public init(cpuMax: Double,  memoryMax: Double,flag:Double) {
        self.performanceСalculator = PerformanceCalculator();
        self.cpuMax=cpuMax;
        self.memoryMax=memoryMax;
        super.init()
        self.performanceСalculator.onReport = { [weak self](performanceReport) in
            self?.update(withPerformanceReport: performanceReport)
        }
        self.performanceСalculator.start()
    }
    
    func update(withPerformanceReport report: PerformanceReport) {
        let performanceStr = String(format: "CPU: %.1f%%, FPS: %d", report.cpuUsage, report.fps)
        
        //单位M
        let bytesInMegabyte = 1024.0 * 1024.0
        

        let usedMemory = Double(report.memoryUsage.used) / bytesInMegabyte
        let totalMemory = Double(report.memoryUsage.total) / bytesInMegabyte
        let memoryStr = String(format: " MEM %.1fMB(%.0fMB) used", usedMemory, totalMemory)
        
        let message = "👮 Performance was blocked for " + performanceStr + memoryStr+" 👮"
        //print(message);
        
        if(self.cpuMax>0&&report.cpuUsage>self.cpuMax){
            fatalError(message);
        }
        if(self.memoryMax>0&&usedMemory>self.memoryMax){
            fatalError(message);
        }
    }
    
    deinit {
        self.performanceСalculator.pause()
    }
    

}
