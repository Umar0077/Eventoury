import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'package:eventoury/web/Traveller/Confirm%20and%20Payment/frontend/Confirm&Payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/Traveller/booking/backend/booking_controller.dart';
import 'package:eventoury/web/top and Bottom bar/top bar web/topbarwidget.dart';
import 'package:eventoury/web/top and Bottom bar/bottom bar web/bottombarwidget.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingController());
    final theme = Theme.of(context);
    
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Responsive breakpoints
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    
    // Responsive padding
    final horizontalPadding = isDesktop ? 80.0 : isTablet ? 40.0 : 20.0;
    final verticalPadding = isDesktop ? 40.0 : isTablet ? 30.0 : 20.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // Top Navigation Bar
          TopBarWidget(),
          
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back Button and Title
                  SizedBox(
                    width: double.infinity,
                    child: _buildHeader(theme, screenWidth, controller),
                  ),
                  SizedBox(height: isDesktop ? 40 : isTablet ? 30 : 20),
                  
                  // Booking Form Section
                  Center(
                    child: _buildBookingContent(theme, screenWidth, controller),
                  ),
                  SizedBox(height: isDesktop ? 60 : isTablet ? 40 : 30),
                  
                  // Footer
                  const BottomBarWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Top nav replaced by shared TopBarWidget

  // nav helper removed; TopBarWidget provides the navigation UI now.

  Widget _buildHeader(ThemeData theme, double screenWidth, BookingController controller) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    
    return Row(
      children: [
        // Back Button
        GestureDetector(
          onTap: controller.goBack,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
                color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back,
              color: theme.iconTheme.color,
              size: isDesktop ? 24 : 20,
            ),
          ),
        ),
        const SizedBox(width: 20),
        
        // Title
        Text(
          'Booking',
          style: TextStyle(
            fontSize: isDesktop ? 32 : isTablet ? 28 : 24,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildBookingContent(ThemeData theme, double screenWidth, BookingController controller) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side - Form
          Expanded(
            flex: 1,
            child: _buildBookingForm(theme, screenWidth, controller),
          ),
          const SizedBox(width: 40),
          // Right side - Destination card
          Expanded(
            flex: 1,
            child: _buildDestinationCard(theme, screenWidth, controller),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _buildBookingForm(theme, screenWidth, controller),
          SizedBox(height: isTablet ? 40 : 30),
          _buildDestinationCard(theme, screenWidth, controller),
        ],
      );
    }
  }

  Widget _buildBookingForm(ThemeData theme, double screenWidth, BookingController controller) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    
    return Container(
      constraints: BoxConstraints(maxWidth: isDesktop ? 500 : 600),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Detail Booking Header
            Text(
              'Detail Booking',
              style: TextStyle(
                fontSize: isDesktop ? 24 : isTablet ? 22 : 20,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.titleLarge?.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Get the best out of darking by creating an account',
              style: TextStyle(
                fontSize: isDesktop ? 16 : 14,
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
            SizedBox(height: isDesktop ? 40 : isTablet ? 30 : 24),
            
            // Guest Name
            _buildFormField(
              label: 'Guest name',
              controller: controller.guestNameController,
              validator: controller.validateGuestName,
              theme: theme,
              placeholder: 'Nazarifa',
            ),
            const SizedBox(height: 20),
            
            // Guest Number
            _buildFormField(
              label: 'Guest number',
              controller: controller.guestNumberController,
              validator: controller.validateGuestNumber,
              theme: theme,
              placeholder: '2',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            
            // Phone Number
            _buildPhoneField(theme, controller),
            const SizedBox(height: 20),
            
            // Email
            _buildFormField(
              label: 'Email',
              controller: controller.emailController,
              validator: controller.validateEmail,
              theme: theme,
              placeholder: 'nazarifa@gmail.com',
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required ThemeData theme,
    required String placeholder,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          style: TextStyle(
            fontSize: 16,
            color: theme.textTheme.bodyLarge?.color,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
            ),
            filled: true,
              fillColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.dividerColor.withOpacity(0.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.dividerColor.withOpacity(0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFFF6B35),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField(ThemeData theme, BookingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Country Code Dropdown
            Container(
              decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                border: Border.all(
                  color: theme.dividerColor.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(() => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.selectedCountryCode.value,
                  onChanged: (value) {
                    if (value != null) {
                      controller.updateCountryCode(value);
                    }
                  },
                  items: controller.countryCodes.map((code) {
                    return DropdownMenuItem(
                      value: code,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          code,
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                    dropdownColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: theme.iconTheme.color,
                  ),
                ),
              )),
            ),
            const SizedBox(width: 12),
            // Phone Number Field
            Expanded(
              child: TextFormField(
                controller: controller.phoneController,
                validator: controller.validatePhone,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.textTheme.bodyLarge?.color,
                ),
                decoration: InputDecoration(
                  hintText: '123 456-789',
                  hintStyle: TextStyle(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                  ),
                  filled: true,
                  fillColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: theme.dividerColor.withOpacity(0.2),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: theme.dividerColor.withOpacity(0.2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFFF6B35),
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDestinationCard(ThemeData theme, double screenWidth, BookingController controller) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    final isMobile = screenWidth <= 768;
    
    return Container(
      constraints: BoxConstraints(maxWidth: isDesktop ? 500 : 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Choice of Destination Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choice of Destination',
                style: TextStyle(
                  fontSize: isDesktop ? 18 : 16,
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
              GestureDetector(
                onTap: controller.changeDestination,
                child: Text(
                  'Change',
                  style: TextStyle(
                    fontSize: isDesktop ? 16 : 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFFF6B35),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Date and Guest Info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.dividerColor.withOpacity(0.1),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: theme.iconTheme.color,
                ),
                const SizedBox(width: 8),
                Text(
                  '11 - 16 April 2025',
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.person,
                  size: 16,
                  color: theme.iconTheme.color,
                ),
                const SizedBox(width: 8),
                Text(
                  controller.guestNumberController.text.isNotEmpty ? controller.guestNumberController.text : "2",
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Destination Card
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Beach Image
                Container(
                  height: isMobile ? 200 : isTablet ? 250 : 280,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('assets/home_screen/events.jpg'), // Using available image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Destination Info
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Beach icon placeholder (using available assets)
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFFF6B35).withOpacity(0.1),
                            ),
                            child: const Icon(
                              Icons.beach_access,
                              color: Color(0xFFFF6B35),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Beach',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: theme.textTheme.titleLarge?.color,
                                  ),
                                ),
                                Text(
                                  'Bali, Indonesia',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: theme.textTheme.bodyMedium?.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      // Price and Book Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$${controller.bookingPrice.value}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFFF6B35),
                                ),
                              ),
                              Text(
                                '/Person',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: theme.textTheme.bodySmall?.color,
                                ),
                              ),
                            ],
                          )),
                          
                          Obx(() => EventouryElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () {
                                    // Validate form before navigating
                                    if (controller.formKey.currentState?.validate() ?? false) {
                                      // pass the booking price to the confirm payment screen
                                      Get.to(() => const ConfirmPaymentScreen(), arguments: {'price': controller.bookingPrice.value});
                                    } else {
                                      Get.snackbar(
                                        'Validation',
                                        'Please complete the booking form',
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    }
                                  },
                            child: controller.isLoading.value
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : const Text(
                                    'Next',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
}