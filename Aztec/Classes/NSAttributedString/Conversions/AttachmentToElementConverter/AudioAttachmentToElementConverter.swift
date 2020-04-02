//
//  AudioAttachmentToElementConverter.swift
//  Alamofire
//
//  Created by Kayvan on 4/2/20.
//

import Foundation
import UIKit

class AudioAttachmentToElementConverter: AttachmentToElementConverter {
    
    func convert(_ attachment: AudioAttachment, attributes: [NSAttributedString.Key : Any]) -> [Node] {
        let element: ElementNode
        
        if let representation = attributes[.videoHtmlRepresentation] as? HTMLRepresentation,
            case let .element(representationElement) = representation.kind {
            
            element = representationElement.toElementNode()
        } else {
            element = ElementNode(type: .audio)
        }
        
        if let attribute = aduioSourceAttribute(from: attachment) {
            element.updateAttribute(named: attribute.name, value: attribute.value)
        }
        
        
        for attribute in attachment.extraAttributes {
            element.updateAttribute(named: attribute.name, value: attribute.value)
        }

//        element.children = element.children + aduioSourceElements(from: attachment)

        return [element]
    }
    
    /// Extracts the Video Source Attribute from a VideoAttachment Instance.
    ///
    private func aduioSourceAttribute(from attachment: AudioAttachment) -> Attribute? {
        guard let source = attachment.url?.absoluteString else {
            return nil
        }
        
        return Attribute(type: .src, value: .string(source))
    }
    

    /// Extracts the Video source elements from a VideoAttachment Instance.
    ///
    private func aduioSourceElements(from attachment: AudioAttachment) -> [Node] {
        var nodes = [Node]()
        if let source = attachment.url?.absoluteString {
            var attributes = [Attribute]()
            let sourceAttribute = Attribute(type: .src, value: .string(source))
            attributes.append(sourceAttribute)
            nodes.append(ElementNode(type: .source, attributes: attributes, children: []))
        }
//        for source in attachment.url {
//            var attributes = [Attribute]()
//            if let src = source.src {
//                let sourceAttribute = Attribute(type: .src, value: .string(src))
//                attributes.append(sourceAttribute)
//            }
//            if let type = source.type {
//                let typeAttribute = Attribute(name: "type", value: .string(type))
//                attributes.append(typeAttribute)
//            }
//            nodes.append(ElementNode(type: .source, attributes: attributes, children: []))
//        }
        return nodes
    }
}
