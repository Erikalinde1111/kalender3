//
//  Project+CoreDataProperties.swift
//  kalender3
//
//  Created by Erika Linde on 15/03/17.
//  Copyright © 2017 Erika Linde. All rights reserved.
//

import Foundation
import CoreData


extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project");
    }

    @NSManaged public var id: Int32
    @NSManaged public var startDate: String?
    @NSManaged public var endDate: String?
    @NSManaged public var label: String?
    @NSManaged public var descript: String?
    @NSManaged public var source: String?
    @NSManaged public var tasks: Task?

}
