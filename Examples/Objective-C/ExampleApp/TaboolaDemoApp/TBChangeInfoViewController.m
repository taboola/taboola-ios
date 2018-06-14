//
//  TBChangeInfoViewController.m
//  TaboolaDemoApp
//

#import "TBChangeInfoViewController.h"

@interface TBChangeInfoViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;
@property (weak, nonatomic) IBOutlet UITextField *modeTextField;
@property (weak, nonatomic) IBOutlet UITextField *publisherTextField;
@property (weak, nonatomic) IBOutlet UITextField *pageTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *pageURLTextField;
@property (weak, nonatomic) IBOutlet UITextField *placementTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) NSArray *arrayOfKeys;
@property (nonatomic) NSArray *defaultValues;

@end

@implementation TBChangeInfoViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.saveButton setEnabled:NO];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    tapGesture.cancelsTouchesInView = YES;
    [self.view addGestureRecognizer:tapGesture];
    
    self.arrayOfKeys = @[@"mode", @"publisher", @"pageType", @"pageURL", @"placement"];
    self.defaultValues = @[@"thumbnails-sdk1", @"betterbytheminute-app", @"article", @"http://www.example.com", @"Mobile"];
    
    [self getDataFromTextFileds];
    [self updateButtonEnabled];
}

#pragma mark - Private Method

- (void)dismissKeyboard {
    [self.view endEditing:true];
}

- (void)getDataFromTextFileds {
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.textFields enumerateObjectsUsingBlock:^(UITextField *textField, NSUInteger index, BOOL * _Nonnull stop) {
        NSString *value = [[NSUserDefaults standardUserDefaults] objectForKey:self.arrayOfKeys[index]];
        if (value == nil) {
            value = self.defaultValues[index];
        }
        textField.text = value;
    }];
}

- (void)saveDataFromTextFields {
    [self.textFields enumerateObjectsUsingBlock:^(UITextField *textField, NSUInteger index, BOOL * _Nonnull stop) {
        [[NSUserDefaults standardUserDefaults] setObject: textField.text forKey:self.arrayOfKeys[index]];
    }];
}

- (void)updateButtonEnabled {
    BOOL isEnabled = true;
    
    for (UITextField* textField in self.textFields) {
        if ([textField.text length] == 0) {
            isEnabled = false;
            break;
        }
    }
    
    [self.saveButton setEnabled:isEnabled];
}

#pragma mark - Actions

- (IBAction)actionDismissViewController:(UIButton *)sender {
    
    if (self.callback) {
        NSMutableDictionary *widgetAttributes = [NSMutableDictionary new];
        NSInteger index = 0;
        for (NSString* key in self.arrayOfKeys) {
            [widgetAttributes setValue:[self.textFields[index] text] forKey:key];
            index++;
        }
        self.callback(widgetAttributes);
    }
    [self saveDataFromTextFields];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)actionChangeTextField:(UITextField *)sender {
    [self updateButtonEnabled];
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    NSInteger currentIndex = [self.textFields indexOfObject:textField];
    if (currentIndex + 1 < [self.textFields count]) {
        [self.textFields[currentIndex + 1] becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return NO;
}

@end
