//
//  NSData+CCCryptUtil.h
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CCCryptUtil)

- (NSData*)AES256EncryptWithKey:(NSString*)key;
- (NSData*)AES256DecryptWithKey:(NSString*)key;

@end
