function handleFileUpload() {
    const inputElement = document.getElementById('ex_file');
    const file = inputElement.files[0];
    const imgFileElement = document.getElementById('previewContainer');

    if (file) {
        const allowedExtensions = ['png', 'jpg', 'jpeg'];
        const fileNameParts = file.name.split('.');
        const fileExtension = fileNameParts[fileNameParts.length - 1].toLowerCase();

        // 파일 확장자가 허용된 확장자인지 확인
        if (allowedExtensions.includes(fileExtension)) {
            const formData = new FormData();
            formData.append('file', file);

            // 이미지 미리보기 업데이트
            const reader = new FileReader();
            reader.onload = function (e) {
                const imgElement = document.createElement('img');
                imgElement.src = e.target.result;
                imgFileElement.innerHTML = ''; // 기존 이미지 지우기
                imgFileElement.appendChild(imgElement);
            };
            reader.readAsDataURL(file);

            // 이미지 미리보기 보이기
            imgFileElement.style.display = 'flex';
        } else {
            alert('지원되지 않는 파일 형식');
            inputElement.value = ''; // 선택된 파일 제거
            imgFileElement.innerHTML = ''; // 이미지 미리보기 지우기
            imgFileElement.style.display = 'none'; // 이미지 미리보기 숨기기
        }
    } else {
        alert('파일을 선택하세요.');
        imgFileElement.innerHTML = ''; // 이미지 미리보기 지우기
        imgFileElement.style.display = 'none'; // 이미지 미리보기 숨기기
    }
}