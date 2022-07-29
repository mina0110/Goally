//
//  Achievements+CoreDataProperties.swift
//  NanoChallenge2
//
//  Created by Minawati on 28/07/22.
//
//

import Foundation
import CoreData


extension Achievements {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Achievements> {
        return NSFetchRequest<Achievements>(entityName: "Achievements")
    }

    @NSManaged public var achievementId: UUID?
    @NSManaged public var desc: String?
    @NSManaged public var isAchieved: Bool
    @NSManaged public var rule: Int16
    @NSManaged public var title: String?
    @NSManaged public var type: String?

}

extension Achievements : Identifiable {

}
