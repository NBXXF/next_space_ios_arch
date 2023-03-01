//
//  NXHelperCellType.swift
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/1.
//

import Foundation
@objc public class NXHelperCellType:NSObject{

    /**
    堆栈
     */
    @objc  public static let typeStack = 1;
    
    /**
     anr
     */
    @objc  public static let typeAnr = 2;
    
    /**
     线程
     */
    @objc  public static let typeThread = 3;
    
    /**
     cpu
     */
    @objc  public static let typeCpu = 4;
    
    /**
    内存
     */
    @objc  public static let typeMemory = 5;
    
    /**
    内存
     */
    @objc  public static let typeProtocal = 6;
}
