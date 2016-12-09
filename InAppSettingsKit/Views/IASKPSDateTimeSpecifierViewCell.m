//
//  IASKPSDateTimeSpecifierViewCell.m
//  Pods
//
//  Created by Willem de Jonge on 01/12/16.
//
//

#import "IASKPSDateTimeSpecifierViewCell.h"
#import "IASKTextField.h"

@interface IASKPSDateTimeSpecifierViewCell()

@end

@implementation IASKPSDateTimeSpecifierViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        datePicker.minimumDate = [NSDate date];
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        // datepicker toolbar setup
        UIToolbar *toolBar = [[UIToolbar alloc] init];
        toolBar.barStyle = UIBarStyleDefault;
        toolBar.translucent = YES;
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
        
        // if you remove the space element, the "done" button will be left aligned
        // you can add more items if you want
        
        NSArray<UIBarButtonItem*> *items = [[NSArray<UIBarButtonItem*> alloc] initWithObjects:space, done, nil];
        
        [toolBar setItems:items animated:NO];
        // toolBar.userInteractionEnabled = true
        [toolBar sizeToFit];

        self.textField.inputAccessoryView = toolBar;
        self.textField.inputView = datePicker;
        
        self.datePicker = datePicker;
    }
    return self;
}

- (void)updateTextField {
    NSDate *date = self.datePicker.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM-dd-yyyy HH:mm:00"];
    
    self.textField.text = [df stringFromDate:date];
}

- (void)datePickerValueChanged:(id)sender{
    [self updateTextField];
}

-(void)resignKeyboard {
    [self updateTextField];
    [self.textField resignFirstResponder];
}

@end
