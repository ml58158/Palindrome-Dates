//
//  ViewController.m
//  Palindrone
//
//  Created by Matt Larkin on 4/21/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIDatePicker *datePickerOne;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePickerTwo;

@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UIButton *calculateButton;

@property NSString *dateOneValue;
@property NSString *dateTwoValue;
@property NSString *daterange;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/**
 *  ReverseString
 *
 *  @param input string of dates
 *
 *  @return reversedString
 */
- (NSString *)reverseString:(NSString *)input {
    NSMutableString *reversedString = [NSMutableString string];
    NSInteger charIndex = [input length];
    while (charIndex > 0) {
        charIndex--;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reversedString appendString:[input substringWithRange:subStrRange]];
    }
    return reversedString;
}

/**
 *  checkForPalindrome
 *
 *  @param str reverseString
 *
 *  @return Boolean Value Yes or No
 */
- (BOOL)checkForPalindrome:(NSString *)str {

    return [str isEqualToString:[self reverseString:str]];

}

/**
 *  Calculate Button
 *
 *  @param sender NSString stringWithFormat:@"%i", dates]
 */
- (IBAction)onCalculateButtonPressed:(UIButton *)sender
{

    [self checkForPalindromes];

}

/**
 *  Checks for Palindromes
 */
-(void)checkForPalindromes
{

    /**
     *  Retrieves date from uidatepickers and converts it into NSDate format
     */

    int dates = 0;

    NSDate *dateOne = self.datePickerOne.date;
    NSDate *dateTwo = self.datePickerTwo.date;

    if ([dateOne compare:dateTwo] == NSOrderedDescending) {
        dateOne = self.datePickerTwo.date;
        dateTwo = self.datePickerOne.date;
    }
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMDDYYYY"];

    NSDate *currentDate = dateOne;
    while ([currentDate compare:dateTwo] == NSOrderedAscending) {

        NSString *dateString = [self convert:currentDate];

        /**
         *  Prints Next Palindrome Day to Console
         */
        if([self checkForPalindrome:dateString]) {
            NSLog(@"The plaindrome dates are: %@", dateString);
            dates++;
        }
    
        /**
         *  Increment current day
         */
        currentDate = [self incrementDate:currentDate];
    }

    /**
     *  Displays count of Palindrome Days
     */
    self.countLabel.text = [NSString stringWithFormat:@"%i", dates];

}

/**
 *  NSDate Conversion
 *
 *  @param incremented day
 *
 *  @return Next Palindrome day
 */
- (NSString *)convert:(NSDate *)date {
    NSString *calDay = [date.description componentsSeparatedByString:@" "][0];
    NSArray *comps = [calDay componentsSeparatedByString:@"-"];
    return [NSString stringWithFormat:@"%@%@%@", comps[1], comps[2], comps[0]];
}

- (NSDate *)incrementDate:(NSDate *)now {
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;

    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:now options:0];
    
    
    return nextDate;

}



@end