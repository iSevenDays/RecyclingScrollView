//for test
#import <Foundation/Foundation.h>
/*
id
name
products[]
 
 */
@interface Data : NSObject
{
}
@property NSMutableArray *products;
@property NSString *name;
- (id)initWithIdent:(NSInteger)ident andName:(NSString *)name;
- (NSMutableArray *)generateArray;
@end
