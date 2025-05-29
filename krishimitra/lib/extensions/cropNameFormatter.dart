String formatCropName(String cropName) {
  return cropName
      .replaceAll('(', '-')      // Replace '(' with '-'
      .replaceAll(')', '')       // Remove ')'
      .replaceAll(' ', '-')      // Replace spaces with hyphens
      .toLowerCase()             // Convert to lowercase
      .replaceAll(RegExp(r'-+'), '-') // Replace consecutive hyphens with a single hyphen
      .replaceAll(RegExp(r'-+$'), ''); // Remove trailing hyphens
}
