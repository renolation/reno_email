import 'package:reno_email/features/domain/email_entity.dart';

const List<EmailEntity> listTemplate = [
  EmailEntity(
      role: 'user',
      type: 'text',
      subject: 'You\'re Invited to My Birthday Celebration!',
      text: '''Dear [Recipient's Name],

I hope this message finds you well! I am excited to invite you to my birthday party, and I would love for you to join the celebration.

**Date:** [Insert Date]  
**Time:** [Insert Time]  
**Location:** [Insert Venue/Address]

It will be a great opportunity to enjoy some good food, fun activities, and wonderful company. Please let me know if you can make it!

Looking forward to celebrating together!

Best,  
[Your Name]  
[Your Contact Information]'''),
  EmailEntity(role: 'user', type: 'text', subject: 'Sick Leave Application', text: '''Dear [Manager's Name],

I hope this message finds you well. I am writing to formally request sick leave due to [briefly explain illness, e.g., "a severe cold" or "flu symptoms"]. 

I am unable to perform my duties effectively and believe it's best for my recovery and the health of the team to take time off. I would like to request leave from [start date] to [end date], and I will ensure that all my responsibilities are managed in my absence.

Please let me know if you need any further information or documentation.

Thank you for your understanding.

Best regards,  
[Your Name]  
[Your Position]  
[Your Contact Information]'''),
  EmailEntity(
      role: 'user', type: 'text', subject: 'Visa Application Request', text: '''Dear [Consulate/Embassy Officer's Name],

I hope this message finds you well. I am writing to formally submit my application for a [type of visa, e.g., "tourist visa", "student visa"] to [destination country].

I plan to travel from [start date] to [end date] for [briefly explain purpose, e.g., "tourism", "studying at XYZ University"]. Attached to this email, you will find all the required documents, including:

1. Completed visa application form
2. Passport-sized photographs
3. A copy of my passport
4. Proof of accommodation
5. Travel itinerary
6. [Any other relevant documents]

I appreciate your assistance with my application and look forward to your positive response. Please let me know if you require any further information.

Thank you for your attention to this matter.

Best regards,  
[Your Name]  
[Your Contact Information]  
[Your Address]'''),
  EmailEntity(role: 'user', type: 'text', subject: 'Thank You!', text: '''Dear [Recipient's Name],

I hope this message finds you well. I wanted to take a moment to express my heartfelt thanks for [briefly explain what you are thanking them for, e.g., "your support during my recent project", "the wonderful gift", "attending my birthday party"].

Your kindness and thoughtfulness truly made a difference, and I am grateful to have you in my life. [You can add a personal touch here, e.g., "I look forward to our next get-together" or "Your support means a lot to me."]

Thank you once again for everything!

Warm regards,  
[Your Name]  
[Your Contact Information]'''),
  EmailEntity(
      role: 'user', type: 'text', subject: 'Apology for Canceling [Event Name]', text: '''Dear [Recipient's Name],

I hope this message finds you well. I am writing to sincerely apologize for the cancellation of [event name, e.g., "the dinner party", "the meeting"] that was scheduled for [date and time].

Unfortunately, [briefly explain reason for cancellation, e.g., "due to unforeseen circumstances", "I am unable to attend due to a personal matter"]. I understand that this may cause inconvenience, and I am truly sorry for any disruption this may have caused to your plans.

I value our relationship and hope to reschedule the event at a later date. Please let me know your availability, as I would love the opportunity to connect.

Thank you for your understanding.

Best regards,  
[Your Name]  
[Your Contact Information]'''),
  EmailEntity(role: 'user', type: 'text', subject: 'Resignation Letter', text: '''Dear [Manager's Name],

I hope this message finds you well. I am writing to formally resign from my position at [Company Name], effective [last working day, typically two weeks from the date of the email].

This decision was not easy and took a lot of consideration. I am grateful for the opportunities I've had to grow and learn during my time at [Company Name]. I appreciate the support and guidance you and the team have provided me.

I am committed to ensuring a smooth transition and will do everything possible to hand over my responsibilities effectively. Please let me know how I can assist during this period.

Thank you once again for everything. I hope to stay in touch, and I look forward to crossing paths in the future.

Warm regards,  
[Your Name]  
[Your Contact Information]''')
];
