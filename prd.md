PRODUCT REQUIREMENTS DOCUMENT
Rjesh Calculator
A Modern, Stylish Calculator App with Neon UI
Document Type	Product Requirements Document (PRD)
Product Name	Rjesh Calculator
Version	1.0 (Initial Draft)
Date Created	January 31, 2026
Platform	Flutter (iOS & Android)
Target Audience	General users, students, professionals
1. DOCUMENT OVERVIEW
1.1 Purpose
This Product Requirements Document (PRD) defines the specifications, features, and technical requirements for the Rjesh Calculator mobile application. It serves as a comprehensive guide for developers, designers, and stakeholders involved in the development process.
1.2 Product Vision
Rjesh Calculator aims to provide users with a visually stunning, highly functional calculator that combines essential mathematical operations with an engaging user experience. The app will stand out through its neon-themed interface, smooth animations, and intuitive design while maintaining calculation accuracy and performance.
1.3 Target Audience
The target audience includes:
General users seeking a stylish alternative to stock calculator apps
Students requiring basic to intermediate mathematical functions
Professionals needing quick calculations with memory functions
Users who appreciate aesthetically pleasing mobile applications
1.4 Success Metrics
User retention rate > 40% after 30 days
Average session duration > 2 minutes
App Store rating ≥ 4.2 stars
10,000+ downloads within first 3 months
Ad click-through rate (CTR) > 1.5%
2. CORE FEATURES
2.1 Basic Mathematical Operations
2.1.1 Supported Operations
Operation	Symbol	Priority Level	Example
Addition	+	Low	5 + 3 = 8
Subtraction	−	Low	10 − 4 = 6
Multiplication	×	High	6 × 7 = 42
Division	÷	High	20 ÷ 4 = 5
Percentage	%	High	50% of 200 = 100
2.1.2 Calculation Behavior
Immediate calculation: Results display dynamically as users input numbers and operations
Operation precedence: Follows standard PEMDAS/BODMAS rules (multiplication and division before addition and subtraction)
Decimal support: Up to 10 decimal places with automatic rounding
Error handling: Division by zero displays 'Error' message
Large number support: Scientific notation for numbers > 1,000,000,000
2.2 Input Control Functions
Function	Button Label	Behavior
Clear Entry	C	Clears current input only, preserves previous calculation
All Clear	AC	Resets calculator completely, clears all memory
Backspace	⌫	Deletes last digit or operation symbol
2.3 Display System
2.3.1 Display Components
Primary Display: Shows current input or result (font size: 48-56px, adaptive)
Secondary Display: Shows previous operation history (font size: 18-22px, dimmed)
Animation: Smooth fade-in effect when numbers appear, slide-up effect when results are calculated
2.3.2 Number Formatting
Thousands separator: Comma for numbers > 999 (e.g., 1,234,567)
Adaptive font sizing: Automatically reduces size for longer numbers to fit display
Overflow handling: Horizontal scroll for extremely long numbers
3. EXTENDED FEATURES
3.1 Memory Functions
Memory functions allow users to store and recall values for complex calculations.
Function	Button	Description
Memory Add	M+	Adds current display value to memory
Memory Subtract	M−	Subtracts current display value from memory
Memory Recall	MR	Displays stored memory value
Memory Clear	MC	Clears stored memory (returns to 0)
Implementation Note: Memory indicator (small 'M' badge) appears in top-right corner when memory contains a value.
3.2 Calculation History
3.2.1 Features
Stores last 10 calculations automatically
Accessible via swipe-up gesture or dedicated history button
Each entry shows: equation, result, and timestamp
Tap any history item to recall it to the main calculator
Clear history button to delete all entries
3.2.2 UI Design
Slide-up panel with semi-transparent background
Each history entry has neon-colored border matching app theme
Smooth scroll animation for browsing history
3.3 Scientific Functions (Optional)
Basic scientific operations accessible via mode toggle. These functions appear in an expandable panel.
Function	Symbol	Description	Input Range
Sine	sin	Trigonometric sine function	Degrees or radians
Cosine	cos	Trigonometric cosine function	Degrees or radians
Tangent	tan	Trigonometric tangent function	Degrees or radians
Logarithm	log	Base-10 logarithm	x > 0
Square Root	√	Square root calculation	x ≥ 0
Implementation Note: Toggle between degrees and radians via settings icon. Scientific panel slides in from right with smooth animation.
4. UI/UX DESIGN GUIDELINES
4.1 Design Philosophy
Rjesh Calculator embraces a modern, minimalist aesthetic with vibrant neon accents. The design prioritizes visual appeal without compromising functionality, creating an engaging experience that feels both futuristic and accessible.
4.2 Color Scheme
4.2.1 Dark Mode (Default)
Element	Color Code	Usage
Background	#0A0E27 → #1A1E3F	Gradient background
Primary Neon	#00F5FF	Accent buttons, highlights
Secondary Neon	#FF00E5	Alternative accents
Tertiary Neon	#39FF14	Success states, equals button
Text Primary	#FFFFFF	Numbers, main text
Text Secondary	#8B92B0	Secondary information, history
4.2.2 Light Mode
Element	Color Code	Usage
Background	#F5F7FA → #FFFFFF	Gradient background
Primary Accent	#0066FF	Primary buttons
Secondary Accent	#FF3366	Secondary buttons
Text Primary	#1A1D2E	Numbers, main text
Text Secondary	#6E7191	Secondary information
4.3 Button Design
4.3.1 Button Categories
Number Buttons (0-9): Large, rounded rectangles with subtle neon glow on dark backgrounds
Operation Buttons (+, −, ×, ÷): Distinct neon outline, slightly smaller than number buttons
Function Buttons (C, AC, ⌫): Muted color scheme, clear iconography
Equals Button (=): Largest button with animated neon pulse effect, positioned prominently
4.3.2 Button Specifications
Property	Specification
Shape	Rounded rectangle (border-radius: 16px)
Size	68x68px (numbers), 58x58px (operations), 140x68px (equals)
Font	Poppins or Roboto, semi-bold, 24px
Spacing	12px gap between buttons
Elevation	Soft shadow (0px 4px 20px rgba(0, 245, 255, 0.3))
Haptic Feedback	Light impact on press
4.4 Animation Specifications
4.4.1 Button Interactions
Press: Scale down to 0.95x with 100ms duration
Release: Scale back to 1.0x with 150ms elastic easing
Glow effect: Neon border intensifies by 40% on press
4.4.2 Display Animations
Number Entry: Fade in with slide-left effect (200ms)
Result Calculation: Scale up from 0.8x to 1.0x with bounce effect (400ms)
Clear Action: Fade out current number (150ms), then reset
Error Display: Shake animation (3 oscillations, 500ms total)
4.4.3 Background Effects
Gradient Animation: Slow 10-second rotation cycle for background gradient
Particle System: Subtle floating particles in background (optional, can be disabled in settings)
4.5 Layout & Responsiveness
4.5.1 Screen Sections
Display Area: Top 30% of screen, contains result display and operation history
Button Grid: Bottom 70% of screen, organized in 4x5 grid (4 columns, 5 rows)
Settings Bar: Top-right corner, contains theme toggle and menu icon
4.5.2 Responsive Design
Small Phones (<360px width): Reduce button size to 58x58px, font to 20px
Standard Phones (360-400px): Default sizing as specified
Large Phones (>400px): Increase button size to 76x76px, maintain spacing proportionally
Tablets: Optimize for landscape mode, expand to 5x6 grid layout
4.6 Nepali Number Support (Optional)
Enable via Settings menu: 'Display in Nepali numerals'
Character mapping: 0→०, 1→१, 2→२, 3→३, 4→४, 5→५, 6→६, 7→७, 8→८, 9→९
Applies to: Display output only, buttons remain in standard numerals for universal recognition
Font recommendation: Noto Sans Devanagari for optimal rendering
5. TECHNICAL REQUIREMENTS
5.1 Development Framework
Framework: Flutter (version 3.16 or higher)
Programming Language: Dart (version 3.2 or higher)
Target Platforms: Android 7.0+ (API level 24), iOS 12.0+
5.2 Required Flutter Packages
Package Name	Version	Purpose
flutter/material	Latest	Core UI components
provider	^6.1.0	State management
shared_preferences	^2.2.0	Local data storage (settings, history)
google_mobile_ads	^5.0.0	AdMob integration
audioplayers	^5.2.0	Button sound effects
flutter_animate	^4.5.0	Animation framework
math_expressions	^2.4.0	Mathematical expression parsing
5.3 Architecture Pattern
MVC (Model-View-Controller) pattern with Provider for state management:
Model: CalculatorModel (handles calculation logic, memory, history)
View: Reusable widget components (CalculatorButton, DisplayScreen, HistoryPanel)
Controller: CalculatorController (manages user input, triggers calculations)
5.4 Core Classes & Structure
Key classes to implement:
CalculatorEngine: Core mathematical operations and expression evaluation
MemoryManager: Handles M+, M−, MR, MC operations
HistoryService: Stores and retrieves calculation history
ThemeProvider: Manages dark/light mode switching
SoundManager: Controls button press sound effects
AdManager: Handles AdMob ad loading and display
5.5 Data Persistence
5.5.1 Settings Storage
Use SharedPreferences to store user preferences:
Theme mode (dark/light)
Sound effects enabled/disabled
Nepali numerals enabled/disabled
Scientific mode angle unit (degrees/radians)
Background animation enabled/disabled
5.5.2 History Storage
Store as JSON array in SharedPreferences:
Maximum 10 entries (FIFO - oldest removed when full)
Each entry contains: expression (string), result (double), timestamp (DateTime)
5.6 Performance Requirements
Metric	Target	Measurement Method
App Launch Time	< 2 seconds	Time from tap to fully interactive
Calculation Response	< 100ms	Time from button press to display update
Animation Frame Rate	60 FPS	Maintain smooth 60fps during all animations
Memory Usage	< 100 MB	Maximum RAM consumption during operation
App Size	< 20 MB	APK size after optimization
5.7 Error Handling
Division by Zero: Display 'Error' with shake animation, require AC to clear
Invalid Operations: Prevent invalid sequences (e.g., multiple decimal points)
Overflow: Switch to scientific notation for values > 999,999,999
Mathematical Domain Errors: Display 'Math Error' for sqrt of negative, log of non-positive
Network Errors: Gracefully handle ad loading failures, show placeholder
6. MONETIZATION STRATEGY
6.1 AdMob Integration
6.1.1 Banner Ads
Placement: Bottom of screen, below button grid
Size: Smart banner (adaptive to device width)
Refresh Rate: 60 seconds
Design Integration: Semi-transparent background to blend with app theme
6.1.2 Interstitial Ads
Trigger Frequency: After every 8 calculations OR every 3 minutes of usage (whichever comes first)
Display Timing: Only when calculator is idle for 2+ seconds (not interrupting active calculations)
User Experience: Pre-load ads to minimize display delay, show loading indicator if needed
Fallback: If ad fails to load, continue normal operation without interruption
6.1.3 Ad Configuration
Test Mode: Use AdMob test ad units during development
Production: Replace with live ad unit IDs before release
GDPR Compliance: Implement consent form for users in EU regions
6.2 Revenue Projections
Conservative estimates based on 10,000 monthly active users:
Metric	Value	Calculation Basis
Average Session Duration	3 minutes	User engagement with calculator
Sessions per User per Day	2	Typical calculator usage pattern
Banner Ad Impressions/User/Day	4	2 sessions × 2 views per session
Banner CPM	$1.50	Industry average for utility apps
Interstitial Impressions/User/Day	0.5	1 ad per 2 days of usage
Interstitial CPM	$8.00	Higher CPM for full-screen ads
Monthly Revenue (10K users)	$800-$1,200	Combined banner + interstitial
6.3 Premium Features (Future Consideration)
While the current version has no premium tier, these features could be considered for future in-app purchases:
Ad-Free Experience ($2.99 one-time purchase)
Advanced Scientific Functions (exponentials, combinatorics, matrix operations)
Custom Themes Pack (5+ additional color schemes)
Cloud Sync for History Across Devices
7. OPTIONAL ENHANCEMENTS
7.1 Sound Effects
7.1.1 Sound Library
Number Press: Soft 'click' sound (100ms duration, 440Hz frequency)
Operation Press: Slightly deeper 'click' (100ms, 330Hz)
Equals Press: Satisfying 'pop' sound (150ms, rising frequency 440→550Hz)
Clear/Delete: Short 'whoosh' sound (80ms)
Error: Alert 'boop' sound (200ms, 220Hz with vibrato)
7.1.2 Implementation Details
Format: OGG files for Android, CAF for iOS
Volume: 70% of system volume (adjustable via system settings)
Toggle: Enable/disable via settings menu (persistent across sessions)
Fallback: Haptic feedback if sounds are disabled or unavailable
7.2 Background Animation Effects
7.2.1 Gradient Animation
Type: Multi-color gradient with slow rotation
Colors: 3-4 complementary colors from neon palette
Animation Duration: 10 seconds per full rotation cycle
Easing: Smooth sine wave for seamless looping
7.2.2 Particle System (Optional)
Particle Count: 15-20 small dots
Behavior: Slow upward float with random horizontal drift
Appearance: Semi-transparent, subtle glow, neon-colored
Performance: CPU-efficient implementation, disable on low-end devices automatically
User Control: Toggle in settings menu
7.3 Accessibility Features
Screen Reader Support: Proper semantic labels for all buttons and display elements
High Contrast Mode: Alternative color scheme for visually impaired users
Large Text Support: Respect system font size settings
Voice Input: Optional integration with system voice recognition for hands-free calculations
7.4 Gesture Controls
Swipe Left: Delete last character (alternative to backspace button)
Swipe Right: Undo last operation
Swipe Up: Open calculation history panel
Swipe Down: Close history panel
Long Press on Result: Copy to clipboard with toast notification
8. DEVELOPMENT TIMELINE & MILESTONES
Estimated development time: 6-8 weeks for MVP (Minimum Viable Product)
Phase	Duration	Deliverables	Status
Phase 1: Setup & Core Logic	Week 1-2	Flutter project setup, basic calculation engine, MVC architecture	Not Started
Phase 2: UI Implementation	Week 2-3	Button grid, display screen, color scheme, basic animations	Not Started
Phase 3: Extended Features	Week 3-4	Memory functions, calculation history, scientific mode	Not Started
Phase 4: Polish & Animation	Week 4-5	Advanced animations, sound effects, background effects	Not Started
Phase 5: AdMob Integration	Week 5-6	Banner ads, interstitial ads, ad placement optimization	Not Started
Phase 6: Testing & QA	Week 6-7	Bug fixes, performance optimization, device testing	Not Started
Phase 7: Beta Release	Week 7-8	Beta testing, user feedback, final adjustments	Not Started
Phase 8: Production Launch	Week 8	App Store submission, marketing materials, launch	Not Started
8.1 Critical Path Items
Calculation Engine: Must be accurate and efficient - this is the foundation
UI/UX Design: Neon theme must be visually appealing without compromising readability
Performance Optimization: Animations must run at 60 FPS on mid-range devices
Ad Integration: Must be non-intrusive to avoid negative reviews
9. TESTING STRATEGY
9.1 Unit Testing
Core components requiring unit tests:
CalculatorEngine: All mathematical operations, edge cases (division by zero, overflow)
MemoryManager: M+, M−, MR, MC operations
HistoryService: Add, retrieve, delete operations
Expression Parser: Complex expressions with multiple operations
9.2 Widget Testing
Button interactions: Verify correct input registration
Display updates: Confirm results appear correctly
Theme switching: Verify color changes apply properly
Animation triggers: Ensure animations play when expected
9.3 Integration Testing
End-to-end calculation flows
Ad loading and display cycles
Settings persistence across app restarts
History storage and retrieval
9.4 Device Testing Matrix
Device Category	Example Models	Test Priority	Key Focus Areas
Low-End Android	Samsung Galaxy A10	High	Performance, memory usage, animation smoothness
Mid-Range Android	Google Pixel 6a	Critical	All features, typical user experience
High-End Android	Samsung Galaxy S23	Medium	Advanced animations, particle effects
iOS (Recent)	iPhone 13, 14	Critical	iOS-specific UI rendering, haptics
iOS (Older)	iPhone 8, X	High	Backwards compatibility, performance
Tablets	iPad Air, Samsung Tab S8	Medium	Landscape mode, expanded layout
9.5 Beta Testing Plan
Recruitment: 50-100 beta testers via TestFlight (iOS) and Google Play Internal Testing (Android)
Duration: 2 weeks minimum
Feedback Collection: In-app survey + feedback form + crash reporting
Success Criteria: <5 critical bugs, average rating ≥4.0 from beta users
10. LAUNCH & MARKETING STRATEGY
10.1 App Store Optimization (ASO)
10.1.1 App Title & Subtitle
Title: 'Rjesh Calculator - Neon Theme'
Subtitle: 'Stylish Calculator with Smooth Animations'
10.1.2 Keywords
Primary: calculator, neon calculator, stylish calculator, animated calculator
Secondary: scientific calculator, memory calculator, calculation history, colorful calculator
10.1.3 App Description
Key points to highlight:
Beautiful neon UI with customizable themes
Smooth animations and satisfying button interactions
Memory functions for complex calculations
Calculation history tracking
Free to use with no hidden costs
10.2 Visual Assets
10.2.1 App Icon
Design: Neon calculator symbol on dark gradient background
Colors: Bright cyan and magenta neon glow
Variants: iOS (1024x1024), Android (512x512), plus all required sizes
10.2.2 Screenshots
Prepare 5-8 screenshots showcasing:
Main calculator interface (dark mode)
Calculation in progress with animations visible
Light mode variant
History panel open
Scientific mode (if implemented)
Settings/customization options
10.3 Launch Checklist
Create promotional video (15-30 seconds) showing key features
Prepare press kit with high-res screenshots and app description
Set up social media accounts (Instagram, Twitter, TikTok)
Reach out to tech review websites and app reviewers
Create landing page or simple website
Plan for post-launch updates and feature additions
11. APPENDICES
11.1 Glossary
Term	Definition
PEMDAS/BODMAS	Order of operations: Parentheses/Brackets, Exponents/Orders, Multiplication/Division, Addition/Subtraction
DXA	Twentieth of a point, unit used in DOCX measurement (1440 DXA = 1 inch)
FPS	Frames Per Second, measurement of animation smoothness
CPM	Cost Per Mille (thousand impressions), advertising metric
CTR	Click-Through Rate, percentage of ad impressions that result in clicks
Haptic Feedback	Physical vibration response to user input
FIFO	First In, First Out, data structure principle for history management
11.2 Button Layout Diagram
Recommended 4x5 button grid layout:
┌─────────────────────────────────────┐
│  AC    C     ⌫     ÷              │
│   7     8     9     ×              │
│   4     5     6     −              │
│   1     2     3     +              │
│   0     .     %     =              │
└─────────────────────────────────────┘
11.3 User Flow Diagram
Basic calculation flow:
App Launch → Display shows '0'
     ↓
User taps number → Number appears with fade-in animation
     ↓
User taps operation → Operation symbol appears in secondary display
     ↓
User taps second number → Number appears
     ↓
User taps '=' → Result animates in with scale-up effect
     ↓
Calculation saved to history → Ready for next calculation
11.4 Version History
Version	Date	Changes
1.0 (Planned)	TBD	Initial release with core features, AdMob integration
1.1 (Future)	TBD	Scientific mode, improved animations
1.2 (Future)	TBD	Additional themes, voice input
END OF DOCUMENT
For questions or clarifications regarding this PRD, please contact:
Product Development Team
Rjesh Calculator Project
Document Version: 1.0
Last Updated: January 31, 2026