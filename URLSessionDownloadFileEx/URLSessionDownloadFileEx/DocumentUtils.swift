//
//  DocumentUtils.swift
//  URLSessionDownloadFileEx
//
//  Created by Lidiomar Fernando dos Santos Machado on 30/01/21.
//

import Foundation

final class DocumentUtils {
    internal static var documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}
