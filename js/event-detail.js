const API_BASE_URL = 'http://localhost:3000';

document.addEventListener('DOMContentLoaded', async () => {
  const errorElement = document.getElementById('detailError');
  const registerModal = document.getElementById('registerModal');
  const closeModalBtn = document.getElementById('closeModal');
  errorElement.style.display = 'none';

  // 1. 获取事件ID
  const urlParams = new URLSearchParams(window.location.search);
  const eventId = urlParams.get('id');

  if (!eventId) {
    errorElement.textContent = 'Invalid request: No event ID provided. Please navigate from the Home or Search page.';
    errorElement.style.display = 'block';
    document.querySelectorAll('.loading').forEach(el => el.textContent = 'Error: No event ID');
    return;
  }

  // 2. 加载事件详情
  await loadEventDetails(eventId);

  // 3. 注册按钮逻辑
  document.getElementById('showRegisterModal').addEventListener('click', () => {
    registerModal.classList.add('active');
  });

  closeModalBtn.addEventListener('click', () => {
    registerModal.classList.remove('active');
  });

  window.addEventListener('click', (e) => {
    if (e.target === registerModal) {
      registerModal.classList.remove('active');
    }
  });

  // -------------------------- 核心函数 --------------------------
  async function loadEventDetails(id) {
    try {
      const response = await fetch(`${API_BASE_URL}/api/events/${id}`);
      
      if (response.status === 404) {
        errorElement.textContent = 'Event not found or has been suspended. Please try another event.';
        errorElement.style.display = 'block';
        document.querySelectorAll('.loading').forEach(el => el.textContent = 'Event not found');
        return;
      }

      if (!response.ok) throw new Error(`Failed to load event: ${response.statusText}`);

      const event = await response.json();
      renderEventDetails(event);

    } catch (err) {
      errorElement.textContent = `Error loading event details: ${err.message}. Please check the API server.`;
      errorElement.style.display = 'block';
      document.querySelectorAll('.loading').forEach(el => el.textContent = 'Load failed');
      console.error('Load event detail error:', err);
    }
  }

  function renderEventDetails(event) {
    // 1. 纯DOM设置详情页大图（无内联属性）
    const heroImgElement = document.querySelector('.event-hero img');
    const heroImage = `event-${event.id}.jpg`;
    // 设置基础属性
    heroImgElement.src = `images/${heroImage}`;
    heroImgElement.alt = `${event.name} - Hero Image`;
    // 设置样式（通过DOM style属性）
    heroImgElement.style.width = '100%';
    heroImgElement.style.height = '100%';
    heroImgElement.style.objectFit = 'cover';
    heroImgElement.style.filter = 'brightness(0.7)';
    // 设置onerror（DOM事件，无内联）
    heroImgElement.onerror = function() {
      this.src = 'https://via.placeholder.com/1200x400?text=Event+Detail';
      this.style.objectFit = 'contain';
      this.style.filter = 'none'; // 清除滤镜，避免占位图过暗
    };

    // 2. 填充类别标签
    document.getElementById('eventCategoryHero').textContent = event.category_name;

    // 3. 填充事件名称
    document.getElementById('eventTitleHero').textContent = event.name;

    // 4. 填充元信息（日期、时间、地点、机构）
    const formattedDate = new Date(event.date).toLocaleString('en-AU', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
    const formattedTime = new Date(event.date).toLocaleString('en-AU', {
      hour: '2-digit',
      minute: '2-digit'
    });
    const eventMeta = document.getElementById('eventMetaHero');
    eventMeta.innerHTML = `
      <span class="date"><i class="fa-regular fa-calendar"></i> ${formattedDate}</span>
      <span class="time"><i class="fa-regular fa-clock"></i> ${formattedTime}</span>
      <span class="location"><i class="fa-solid fa-location-dot"></i> ${event.location}</span>
      <span class="org"><i class="fa-solid fa-building"></i> ${event.org_name}</span>
    `;

    // 5. 填充事件描述
    document.getElementById('eventDescription').textContent = event.description;

    // 6. 填充事件目的
    document.getElementById('eventPurpose').textContent = event.purpose;

    // 7. 填充机构使命
    document.getElementById('orgMission').textContent = event.mission;

    // 8. 填充机构联系方式
    document.getElementById('orgContact').textContent = `${event.contact_email} | ${event.contact_phone}`;

    // 9. 填充门票价格
    const ticketPrice = event.ticket_price === 0 
      ? 'Free Entry (Donations Encouraged)' 
      : `$${Number(event.ticket_price).toFixed(2)} per ticket (100% goes to charity)`;
    document.getElementById('ticketPrice').textContent = ticketPrice;

    // 10. 填充筹款进度
    const currentAmount = `$${Number(event.current_amount).toFixed(2)}`;
    const goalAmount = `$${Number(event.goal_amount).toFixed(2)}`;
    const progressPercentage = Math.min(Math.round((event.current_amount / event.goal_amount) * 100), 100);
    document.getElementById('currentAmount').textContent = currentAmount;
    document.getElementById('goalAmount').textContent = goalAmount;
    document.getElementById('progressPercent').textContent = `${progressPercentage}% Complete`;

    // 11. 进度条动画
    const progressFill = document.getElementById('progressFill');
    setTimeout(() => {
      progressFill.style.width = `${progressPercentage}%`;
    }, 500);
  }
});